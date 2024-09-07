async function readFromFirestore(db, collection) {
    try {
        const snapshot = await db.collection(collection).get();
        const items = [];

        snapshot.forEach(doc => {
            items.push({ id: doc.id, ...doc.data() });
        });

        console.log("✅ Words retrieved from Firestore successfully.");
        return items;
        
    } catch (error) {
        console.error("🛑 Error reading words from Firestore:", error);
        return [];
    }
}

module.exports = readFromFirestore;
