const generateWords = async (
    model,
    complexity,
    numberOfGenerations,
    blacklist = []
  ) => {
    const prompt = `
      You are a helpful language learning assistant. Your task is to generate random words to improve the user's vocabulary based on the given complexity level: ${complexity} (easy/medium/hard).
      Generate ${numberOfGenerations} random words appropriate for the ${complexity} level, but avoid the following words: ${blacklist.join(
        ", "
      )}.
      Provide a clear, concise definition for every word.
      Use every word in a simple example sentence.
      Offer a brief explanation of how the word is commonly used or any notable connotations.
    
      Output **only** the JSON in the following format:
      [
        {
          "word": "[Generated word]",
          "definition": "[Clear, concise definition]",
          "example": "[Sentence using the word]",
          "complexity": [Value of complexity<easy/medium/hard> for which this was generated],
          "usage": "[Brief explanation of common usage or connotations]"
        }
      ]
      `;
  
    const result = await model.generateContent(prompt);
    const responseText = await result.response.text();
  
    try {
      // Clean the response to remove any unwanted characters
      const cleanedResponse = responseText
        .replace(/```json/g, '')   // Remove the starting markdown if present
        .replace(/```/g, '')       // Remove any ending markdown
        .trim();                   // Trim any extra spaces or newlines
  
      // Parse the cleaned response
      const generatedWords = JSON.parse(cleanedResponse);
  
      // Convert both blacklist and generated words to lowercase for comparison
      const filteredWords = generatedWords.filter(
        (wordObj) =>
          !blacklist
            .map((word) => word.toLowerCase())
            .includes(wordObj.word.toLowerCase())
      );
  
      // Check if the number of filtered words is less than the desired amount
      if (filteredWords.length < numberOfGenerations) {
        console.warn("Some words were blacklisted, regenerating more words...");
  
        // Recursively call the function with the updated history and blacklist
        const newWords = await generateWords(
          model,
          complexity,
          numberOfGenerations - filteredWords.length,
          [...blacklist, ...filteredWords.map((wordObj) => wordObj.word)]
        );
        return [...filteredWords, ...newWords];
      }
  
      return filteredWords;
    } catch (e) {
      console.error("Error parsing JSON:", e);
      console.error("Response received:", responseText); // Log the raw response for debugging
      return [];
    }
  };
  
  module.exports = generateWords;
  