import Foundation

// Yanıtın modelini tanımlayın
struct OpenAIResponse: Codable {
    struct Choice: Codable {
        let text: String
    }
    let choices: [Choice]
}

class OpenAIManager {
    private let apiUrl = URL(string: "https://api.openai.com/v1/engines/davinci/completions")!
    private var apiKey: String {
           return "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"
       }

    private func askQuestion(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: apiUrl)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let requestBody: [String: Any] = ["prompt": prompt, "max_tokens": 450]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               guard let data = data else {
                   completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                   return
               }
               do {
                   let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                   if let answer = openAIResponse.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) {
                       completion(.success(answer))
                   } else {
                       completion(.failure(NSError(domain: "No answer", code: 0, userInfo: nil)))
                   }
               } catch {
                   completion(.failure(error))
               }
           }
           task.resume()
    }
    
    func askSolutionForMathProblem(_ latex: String, completion: @escaping (Result<String, Error>) -> Void) {
        let prompt = "Solve the following expression: \(latex)"
        askQuestion(prompt, completion: completion)
    }
}


