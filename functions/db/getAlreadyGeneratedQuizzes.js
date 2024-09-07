const readFromFirestore = require("./readFromFirestore");

/// returns List<String>
async function getAlreadyGeneratedQuizzes(db) {
  const quizzes = await readFromFirestore(db, "quizPool");

  return quizzes.map((obj) => {
    return obj.sentence;
  });
}

module.exports = getAlreadyGeneratedQuizzes;
