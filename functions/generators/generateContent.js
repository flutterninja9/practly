const generateContent = async (model, type, complexity, count, blacklist = []) => {
    const promptTemplates = {
      word: `Generate ${count} random ${complexity} words for language learning. Avoid: ${blacklist.join(", ")}. Format: [{"word": "...", "definition": "...", "example": "...", "complexity": "...", "usage": "used complexity in small letters"}]. Ensure that the json is correct and parseable at client side.`,
      sentence: `Generate ${count} ${complexity} sentences for speaking practice. Avoid: ${blacklist.join(", ")}. Format: [{"sentence": "...", "explanation": "...", "tip": "...", "complexity": "used complexity in small letters"}]. Ensure that the json is correct and parseable at client side.`,
      quiz: `Generate ${count} ${complexity} grammar quiz questions. Avoid: ${blacklist.join(", ")}. Format: [{"sentence": "...", "complexity": "used complexity in small letters", "options": {"a": "...", "b": "...", "c": "...", "d": "..."}, "correct_answer": "..."}]. Ensure that the json is correct and parseable at client side.`
    };
  
    const prompt = promptTemplates[type];
    const result = await model.generateContent(prompt);
    const responseText = await result.response.text();
  
    try {
      const generatedContent = JSON.parse(responseText.replace(/```json|```/g, '').trim());
      return generatedContent.filter(item => !blacklist.includes(item[type]?.toLowerCase() ?? item[type]));
    } catch (e) {
      console.error(`Error parsing ${type} JSON:`, e);
      return [];
    }
  };
  
  module.exports = generateContent;