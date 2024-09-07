const generateSentences = async (model, complexity, numberOfGenerations) => {
    const prompt = `
    You are a helpful language learning assistant. Your task is to generate sentences for speaking practice based on the given complexity level: ${complexity} (easy/medium/hard).
    Generate ${numberOfGenerations} sentences appropriate for the ${complexity} level.
    Provide a brief explanation of any challenging words or phrases in the sentence.
    Offer a pronunciation tip for a word or sound in the sentence that might be difficult for language learners.
    Output **only** the JSON in the following format:
    [
     {
      "sentence": "[Generated Sentence]",
      "explanation": "[Brief explanation of any challenging words or phrases]",
      "tip": "[Tip for pronouncing a difficult word or sound]"
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
  
  module.exports = generateSentences;
  