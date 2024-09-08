const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleGenerativeAI } = require("@google/generative-ai");
const generateContent = require("./generators/generateContent");
const writeToFirestore = require("./db/writeToFirestore");
const getAlreadyGeneratedContent = require("./db/getAlreadyGeneratedContent.js");

admin.initializeApp();
const db = admin.firestore();

exports.getDataFromFirestore = functions
  .runWith({ 
    secrets: ["GEMINI_KEY"],
    timeoutSeconds: 540, // Increase timeout to 9 minutes
    memory: "1GB" // Increase memory if needed
  })
  .https.onRequest(async (req, res) => {
    try {
      const complexity = req.query.complexity;
      const generationCount = parseInt(req.query.generationCount);

      const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY);
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

      const contentTypes = ["word", "sentence", "quiz"];
      const results = {};

      // Fetch all existing content in parallel
      const existingContent = await Promise.all(
        contentTypes.map(type => getAlreadyGeneratedContent(db, `${type}Pool`))
      );

      // Generate new content for all types in parallel
      await Promise.all(contentTypes.map(async (type, index) => {
        const newContent = await generateContent(
          model,
          type,
          complexity,
          generationCount,
          existingContent[index]
        );
        results[`${type}s`] = newContent;
        await writeToFirestore(db, newContent, `${type}Pool`);
      }));

      res.status(200).json({
        complexity,
        generationCount,
        ...results
      });
    } catch (error) {
      console.error("Error in cloud function:", error);
      res.status(500).send("Error processing request");
    }
  });