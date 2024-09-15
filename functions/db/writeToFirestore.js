async function writeToFirestore(db, content, collection) {
  try {
      const batch = db.batch();

      // Check if content is an array, if not convert it to an array
      const items = Array.isArray(content) ? content : [content];
  
      // Iterate over the array (single or multiple items)
      items.forEach(c => {
          const cRef = db.collection(collection).doc();
          batch.set(cRef, c);
      });
  
      await batch.commit();
      console.log("✅ Items written to Firestore successfully.");
      
  } catch (error) {
      console.error("🛑 Error writing items to Firestore:", error);
  }
}

module.exports = writeToFirestore;
