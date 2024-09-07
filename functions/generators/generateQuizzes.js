const generateQuizzes = async (model, complexity, numberOfGenerations) => {
    const prompt = `
    You are an English grammar teacher with over 20 years of experience. Generate ${numberOfGenerations} ${complexity} grammar-focused quiz questions. Each question must contain a sentence with a blank space and four multiple-choice options. One option must be correct. 
    Output **only** the JSON in the following format:
    [
      {
        "sentence": "She is looking forward to ____ her vacation.",
        "options": {
          "a": "start",
          "b": "starting",
          "c": "started",
          "d": "starts"
        },
        "correct_answer": "b"
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
  
  module.exports = generateQuizzes;
  