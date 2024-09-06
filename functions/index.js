const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.getDataFromFirestore = functions.https.onRequest(async (req, res) => {
  try {
    res.status(200).json({});
  } catch (error) {
    console.error("Error reading data from Firestore:", error);
    res.status(500).send("Error reading data from Firestore");
  }
});
