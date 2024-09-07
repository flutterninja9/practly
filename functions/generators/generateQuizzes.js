const generateQuizzes = async (model, complexity, numberOfGenerations, blacklist = []) => {
    const prompt = `
    You are an English grammar teacher with over 20 years of experience. Generate ${numberOfGenerations} ${complexity} grammar-focused quiz questions. Each question must contain a sentence with a blank space and four multiple-choice options. One option must be correct, but avoid the following questions: ${blacklist.join(", ")}.
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
    const responseText = await result.response.text();

    try {
        // Clean the response to remove any unwanted characters
        const cleanedResponse = responseText
            .replace(/```json/g, '')   // Remove the starting markdown if present
            .replace(/```/g, '')       // Remove any ending markdown
            .trim();                   // Trim any extra spaces or newlines

        // Parse the cleaned response
        const generatedQuizzes = JSON.parse(cleanedResponse);

        // Convert both blacklist and generated quizzes to lowercase for comparison
        const filteredQuizzes = generatedQuizzes.filter(
            (quizObj) =>
                !blacklist
                    .map((question) => question.toLowerCase())
                    .includes(quizObj.sentence.toLowerCase())
        );

        // Check if the number of filtered quizzes is less than the desired amount
        if (filteredQuizzes.length < numberOfGenerations) {
            console.warn("Some questions were blacklisted, regenerating more questions...");

            // Recursively call the function with the updated history and blacklist
            const newQuizzes = await generateQuizzes(
                model,
                complexity,
                numberOfGenerations - filteredQuizzes.length,
                [...blacklist, ...filteredQuizzes.map((quizObj) => quizObj.sentence)]
            );
            return [...filteredQuizzes, ...newQuizzes];
        }

        return filteredQuizzes;
    } catch (e) {
        console.error("Error parsing JSON:", e);
        console.error("Response received:", responseText); // Log the raw response for debugging
        return [];
    }
};

module.exports = generateQuizzes;
