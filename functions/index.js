const functions = require("firebase-functions");
const admin = require("firebase-admin");
const generateWords = require('./generators/generateWords');
const generateSentences = require('./generators/generateSentences');
const generateQuizzes = require('./generators/generateQuizzes');
const writeToFirestore = require("./db/writeToFirestore");
const { GoogleGenerativeAI } = require("@google/generative-ai");

admin.initializeApp();
const db = admin.firestore();

exports.getDataFromFirestore = functions.https.onRequest(async (req, res) => {
  try {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

    const words = await generateWords(model, "easy", 5);
    // await writeToFirestore(db, words, "wordPool");
    const sentences = await generateSentences(model, "easy", 5);
    // await writeToFirestore(db, sentences, "sentencePool");
    const quizzes = await generateQuizzes(model, "easy", 5);
    // await writeToFirestore(db, quizzes, "quizPool");

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