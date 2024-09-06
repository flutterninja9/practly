const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleGenerativeAI } = require("@google/generative-ai");
admin.initializeApp();

exports.getDataFromFirestore = functions.https.onRequest(async (req, res) => {
  try {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY)
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

    const generatedWord =await generateWord(model, "easy");

    res.status(200).json({
      "word": generatedWord,
    });
  } catch (error) {
    console.error("Error reading data from Firestore:", error);
    res.status(500).send("Error reading data from Firestore");
  }
});

async function generateWord(model, complexity) {
  let prompt = `
You are a helpful language learning assistant. Your task is to generate a random word to improve the user's vocabulary based on the given complexity level: ${complexity} (easy/medium/hard).

Generate 100 random words appropriate for the ${complexity} level.
Provide a clear, concise definition for every word.
Use every word in a simple example sentence.
Offer a brief explanation of how the word is commonly used or any notable connotations.

Remember:
- For "easy" words, use common, everyday vocabulary suitable for beginners.
- For "medium" words, use more advanced vocabulary that an intermediate learner might encounter.
- For "hard" words, use sophisticated or specialized vocabulary that would challenge advanced learners.

Output Format:
[
  {
    "word": "[Generated word]",
    "definition": "[Clear, concise definition]",
    "example": "[Sentence using the word]",
    "usage": "[Brief explanation of common usage or connotations]"
  },
  /// 99 more
]

Ensure that any double quotes inside the sentence, explanation, or tip are properly escaped with a backslash (\\) to make the JSON valid.

Here is an example of a properly formatted JSON response:
[
  {
    "word": "Quaint",
    "definition": "Pleasingly old-fashioned",
    "example": "The quaint little cottage was a welcome sight after a long day of travel.",
    "usage": "Quaint is often used to describe things that are charming or nostalgic, especially buildings, towns, or objects that evoke a sense of the past."
  },
  /// 99 more...
]

Please ensure that the JSON you provide is well-formed and safe to parse in a programming environment.
  `;

  const result = await model.generateContent(prompt);
  const response = result.response.text();

  return response;
}
