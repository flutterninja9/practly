const readFromFirestore = require("./readFromFirestore");

/// returns List<String>
async function getAlreadyGeneratedSentences(db) {
  const sentences = await readFromFirestore(db, "sentencePool");

  return sentences.map((obj) => {
    return obj.sentence;
  });
}

module.exports = getAlreadyGeneratedSentences;
