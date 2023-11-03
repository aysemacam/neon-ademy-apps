import Foundation

class OpenAIApiService {
    let apiKey = AppStrings.apiKey
    let apiUrl = "https://api.openai.com/v1/chat/completions"
    
    func askQuestion(_ question: String, completion: @escaping (String) -> Void) {
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let prompt = "I want you to act like a mathematician. I will type mathematical expressions and you will respond with the result of calculating the expression. I want you to answer step by step. Steps should like be ordered by Step-1, Step-2, Step-3. Give the final solution as Solution: answer but only answer not any explanation. Solution should be only solution but no any words. When I need to tell you something in English, I'll do it by putting the text inside square brackets {like this}. And this expression will be a latex expression. My first expression is: {\(question)}"
        
        let messages = [
            ["role": "system", "content": "You are a helpful assistant."],
            ["role": "user", "content": prompt]
        ]
        
        let postData: [String: Any] = ["model": "gpt-3.5-turbo", "messages": messages]
        let jsonData = try? JSONSerialization.data(withJSONObject: postData)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(json)")
                    
                    if let errorInfo = json["error"] as? [String: Any],
                       let errorMessage = errorInfo["message"] as? String {
                        completion("API Error: \(errorMessage)")
                    } else if let choices = json["choices"] as? [[String: Any]],
                              let firstChoice = choices.first,
                              let text = firstChoice["message"] as? [String: Any],
                              let content = text["content"] as? String {
                        completion(content)
                    } else {
                        let errorMessage = json["error"] as? String ?? "Unexpected response format"
                        completion("Failed to parse response: \(errorMessage)")
                    }
                } else {
                    completion("Failed to parse JSON")
                }
            } catch {
                completion("Failed to parse JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


