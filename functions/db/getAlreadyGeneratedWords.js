const readFromFirestore = require("./readFromFirestore");

/// returns List<String>
async function getAlreadyGeneratedWords(db) {
  const words = await readFromFirestore(db, "wordPool");

  return words.map((obj) => {
    return obj.word;
  });
}

module.exports = getAlreadyGeneratedWords;
