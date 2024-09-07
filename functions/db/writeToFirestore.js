async function writeToFirestore(db, content, collection) {
    try {
        const batch = db.batch();
    
        content.forEach(c => {
          const cRef = db.collection(collection).doc();
          batch.set(cRef, c);
        });
    
        await batch.commit();
        console.log("✅ Words written to Firestore successfully.");
        
      } catch (error) {
        console.error("🛑 Error writing words to Firestore:", error);
      }
}

module.exports = writeToFirestore;