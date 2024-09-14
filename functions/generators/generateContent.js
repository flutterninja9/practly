const generateContent = async (
  model,
  type,
  complexity,
  count,
  blacklist = []
) => {
  const promptTemplates = {
    word: `Generate ${count} random ${complexity} words for language learning. Avoid: ${blacklist.join(
      ", "
    )}. Format: [{"word": "...", "definition": "...", "example": "...", "complexity": "${complexity.toLowerCase()}", "usage": "..."}]. Ensure that the json is correct and parseable at client side.`,
    sentence: `Generate ${count} ${complexity} sentences for speaking practice. Avoid: ${blacklist.join(
      ", "
    )}. Format: [{"sentence": "...", "explanation": "...", "tip": "...", "complexity": "${complexity.toLowerCase()}"}]. Ensure that the json is correct and parseable at client side.`,
    quiz: `Generate ${count} ${complexity} grammar quiz questions. Avoid: ${blacklist.join(
      ", "
    )}. Format: [{"sentence": "...", "complexity": "${complexity.toLowerCase()}", "options": {"a": "...", "b": "...", "c": "...", "d": "..."}, "correct_answer": "..."}]. Ensure that the json is correct and parseable at client side.`,
    challenge: `Generate an array containing exactly ${count} items that are a mixture of grammar quiz questions and vocabulary-building sentences. The items should be of ${complexity} complexity. Avoid: ${blacklist.join(
      ", "
    )}. 

The output should be a valid JSON array with the following structure:
[
  {
    "type": "quiz",
    "sentence": "<Sentence with a blank>",
    "complexity": "${complexity.toLowerCase()}",
    "options": {
      "a": "<Option A>",
      "b": "<Option B>",
      "c": "<Option C>",
      "d": "<Option D>"
    },
    "correct_answer": "<Correct Option>"
  },
  {
    "type": "sentence",
    "complexity": "${complexity.toLowerCase()}",
    "sentence": "<Useful sentence that improves vocabulary>",
    "explanation": "<Explanation of why this sentence is useful>",
    "tip": "<Optional Tip to improve speaking or understanding>"
  }
]

Ensure the following:
1. The array contains exactly ${count} items.
2. There's a mix of both "quiz" and "sentence" types.
3. No duplicate items are generated.
4. All JSON is correctly formatted and parseable.
5. All fields are filled with appropriate content.
6. The complexity level is consistent across all items.

Return only the JSON array without any additional text or explanations.`,
  };

  const prompt = promptTemplates[type];
  
  const result = await model.generateContent(prompt);
  const responseText = await result.response.text();

  try {
    const generatedContent = JSON.parse(
      responseText.replace(/```json|```/g, "").trim()
    );
    return generatedContent.filter(
      (item) => !blacklist.includes(item[type]?.toLowerCase() ?? item[type])
    );
  } catch (e) {
    console.error(`Error parsing ${type} JSON:`, e);
    return [];
  }
};

module.exports = generateContent;
