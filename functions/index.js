const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleGenerativeAI } = require("@google/generative-ai");
const generateContent = require("./generators/generateContent");
const writeToFirestore = require("./db/writeToFirestore");
const getAlreadyGeneratedContent = require("./db/getAlreadyGeneratedContent.js");
const readFromFirestore = require("./db/readFromFirestore.js");

admin.initializeApp();
const db = admin.firestore();

// Common configuration for functions
const functionConfig = {
  secrets: ["GEMINI_KEY"],
  timeoutSeconds: 540,
  memory: "1GB",
};

// Helper function to initialize Gemini model
const initializeGeminiModel = () => {
  const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY);
  return genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
};

exports.getDataFromFirestore = functions
  .runWith(functionConfig)
  .https.onRequest(async (req, res) => {
    try {
      const { complexity, generationCount } = req.query;
      const model = initializeGeminiModel();

      const contentTypes = ["word", "sentence", "quiz"];
      const results = {};

      // Fetch all existing content in parallel
      const existingContent = await Promise.all(
        contentTypes.map((type) =>
          getAlreadyGeneratedContent(db, `${type}Pool`)
        )
      );

      // Generate new content for all types in parallel
      await Promise.all(
        contentTypes.map(async (type, index) => {
          const newContent = await generateContent(
            model,
            type,
            complexity,
            generationCount,
            existingContent[index]
          );
          results[`${type}s`] = newContent;
          await writeToFirestore(db, newContent, `${type}Pool`);
        })
      );

      res.status(200).json({
        complexity,
        generationCount,
        ...results,
      });
    } catch (error) {
      console.error("Error in cloud function:", error);
      res.status(500).send("Error processing request");
    }
  });

exports.generateDailyChallenge = functions
  .runWith(functionConfig)
  .https.onRequest(async (req, res) => {
    try {
      const { complexity, generationCount } = req.query;
      const model = initializeGeminiModel();
      const type = "challenge";

      // Fetch all existing content
      const existingContent = await readFromFirestore(db,`${type}Pool`);

      const blackList = existingContent
        .flatMap((item) => item.questions)
        .map((question) => question.sentence)
        .filter(Boolean);


      // Generate new content
      const newContent = await generateContent(
        model,
        type,
        complexity,
        generationCount,
        blackList,
      );

      // Save the newly generated content to firestore
      const challenge = {
        questions: newContent,
        complexity: complexity,
        createdOn: new Date(new Date().setUTCHours(0, 0, 0, 0)).toISOString(),
        expiresOn: new Date(
          new Date().setUTCHours(23, 59, 59, 999)
        ).toISOString(), // Expire at the end of the current UTC day
      };

      await writeToFirestore(db, challenge, `${type}Pool`);

      res.status(200).json(challenge);
    } catch (error) {
      console.error("Error in cloud function:", error);
      res.status(500).send("Error processing request");
    }
  });
