const readFromFirestore = async (db, collectionName) => {
  const snapshot = await db.collection(collectionName).get();

  return snapshot.docs.map(doc => doc.data());
};

module.exports = readFromFirestore;
