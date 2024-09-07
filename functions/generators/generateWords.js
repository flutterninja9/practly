const generateWords = async (model, complexity, numberOfGenerations) => {
    const prompt = `
    You are a helpful language learning assistant. Your task is to generate a random word to improve the user's vocabulary based on the given complexity level: ${complexity} (easy/medium/hard).
    Generate ${numberOfGenerations} random words appropriate for the ${complexity} level.
    Provide a clear, concise definition for every word.
    Use every word in a simple example sentence.
    Offer a brief explanation of how the word is commonly used or any notable connotations.
    Output **only** the JSON in the following format:
    [
      {
        "word": "[Generated word]",
        "definition": "[Clear, concise definition]",
        "example": "[Sentence using the word]",
        "usage": "[Brief explanation of common usage or connotations]"
      }
    ]
    `;
    
    const result = await model.generateContent(prompt);
    const response = await result.response.text();
  
    try {
      return JSON.parse(response);
    } catch (e) {
      console.log(e);
      return {};
    }
  };
  
  module.exports = generateWords;
  