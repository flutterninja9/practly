const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleGenerativeAI } = require("@google/generative-ai");
admin.initializeApp();

exports.getDataFromFirestore = functions.https.onRequest(async (req, res) => {
  try {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

    const words = await generateWords(model, "easy", 5);
    const sentences = await generateSentences(model, "easy", 5);
    const quizzes = await generateQuizzes(model, "easy", 5);

    res.status(200).json({
      words: words,
      sentences: sentences,
      quizzes: quizzes,
    });
  } catch (error) {
    console.error("Error reading data from Firestore:", error);
    res.status(500).send("Error reading data from Firestore");
  }
});

async function generateWords(model, complexity, numberOfGenerations) {
  let prompt = `
You are a helpful language learning assistant. Your task is to generate a random word to improve the user's vocabulary based on the given complexity level: ${complexity} (easy/medium/hard).

Generate ${numberOfGenerations} random words appropriate for the ${complexity} level.
Provide a clear, concise definition for every word.
Use every word in a simple example sentence.
Offer a brief explanation of how the word is commonly used or any notable connotations.

Remember:
- For "easy" words, use common, everyday vocabulary suitable for beginners.
- For "medium" words, use more advanced vocabulary that an intermediate learner might encounter.
- For "hard" words, use sophisticated or specialized vocabulary that would challenge advanced learners.

Output **only** the JSON in the following format:
[
  {
    "word": "[Generated word]",
    "definition": "[Clear, concise definition]",
    "example": "[Sentence using the word]",
    "usage": "[Brief explanation of common usage or connotations]"
  },
  /// ${numberOfGenerations - 1} more
]

Do not include any extra text or explanations. Return **only** the JSON array.`;

  const result = await model.generateContent(prompt);
  const response = result.response.text();

  try {
    return JSON.parse(response);
  } catch (e) {
    return {};
  }
}

async function generateSentences(model, complexity, numberOfGenerations) {
  let prompt = `
You are a helpful language learning assistant. Your task is to generate sentences for speaking practice based on the given complexity level: ${complexity} (easy/medium/hard). The sentence should help users improve their pronunciation, fluency, and vocabulary.

Generate ${numberOfGenerations} sentences appropriate for the ${complexity} level.
Provide a brief explanation of any challenging words or phrases in the sentence.
Offer a pronunciation tip for a word or sound in the sentence that might be difficult for language learners.

Remember:

- For "easy" sentences, use common vocabulary and simple grammatical structures suitable for beginners.
- For "medium" sentences, incorporate more advanced vocabulary and grammatical structures that an intermediate learner might encounter.
- For "hard" sentences, use sophisticated vocabulary, idiomatic expressions, or complex grammatical structures that would challenge advanced learners.

Ensure your explanations are clear and your pronunciation tips are helpful for language learners.

Additional guidelines:
- Vary the topics of the sentences to cover a wide range of everyday situations and subjects.
- Include a mix of statement, question, and exclamation sentences across different generations.
- For medium and hard levels, occasionally include common idioms or colloquial expressions.
- Ensure that the sentences are natural and something a native speaker would likely say in conversation.

**Output only the following JSON format without any other text:**

[
 {
  "sentence": "[Generated Sentence]",
  "explanation": "[Brief explanation of any challenging words or phrases]",
  "tip": "[Tip for pronouncing a difficult word or sound]"
 }
 // ${numberOfGenerations - 1} more
]

Do not add any explanations or extra text. Return **only** the JSON array, ensuring that it is well-formed and safe to parse in a programming environment. Escape any double quotes inside the sentence, explanation, or tip with a backslash (\\).`;

  const result = await model.generateContent(prompt);
  const response = result.response.text();

  try {
    return JSON.parse(response);
  } catch (e) {
    console.log(e);

    return {};
  }
}

async function generateQuizzes(model, complexity, numberOfGenerations) {
  let prompt = `
  You are an English grammar teacher with over 20 years of experience, and all your students have become masters of the English language.
  
  Generate ${numberOfGenerations} ${
    complexity.name
  } grammar or vocabulary-focused quiz questions with a sentence that contains a blank space to fill in. Provide four multiple-choice options, including the correct answer. The sentence should test the user's understanding of word usage, verb forms, prepositions, or other grammatical concepts. Ensure that the difficulty level matches the specified level (${
    complexity.name
  }). 
  
  Remember:
  - Do not generate incorrect or misleading options, as this app is used by many students to learn English.
  - Ensure all questions and options are accurate.
  
  **Output only the following JSON format without any other text:**
  
  [
    {
      "sentence": "She is looking forward to ____ her vacation.",
      "options": {
        "a": "start",
        "b": "starting",
        "c": "started",
        "d": "starts"
      },
      "correct_answer": "b"
    }
    // ${numberOfGenerations - 1} more 
  ]
  
  Do not include any additional text or explanations. Only return the JSON array, ensuring that it is well-formed and safe to parse. Escape any double quotes inside the sentence or options with a backslash (\\).`;

  const result = await model.generateContent(prompt);
  const response = result.response.text();

  try {
    return JSON.parse(response);
  } catch (e) {
    console.log(e);

    return {};
  }
}
