const getAlreadyGeneratedContent = async (db, collectionName) => {
  const snapshot = await db.collection(collectionName).get();
  const contentType = collectionName.replace('Pool', '');
  
  return snapshot.docs.reduce((acc, doc) => {
    const content = doc.data()[contentType];
    
    if (content !== undefined && content !== null) {
      if (typeof content === 'string') {
        acc.push(content.toLowerCase());
      } else if (typeof content === 'object' && content[contentType]) {
        // Handle nested objects (e.g., for quizzes)
        acc.push(content[contentType].toLowerCase());
      }
      // For other types (like numbers), we might want to convert to string
      // else {
      //   acc.push(String(content).toLowerCase());
      // }
    }
    
    return acc;
  }, []);
};

module.exports = getAlreadyGeneratedContent;