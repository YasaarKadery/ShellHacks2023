//
//  ChatModel.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//


import Foundation
/// Fetches a bot response based on the provided question.
///
/// This function sends a POST request to a predefined Flask endpoint
/// and parses the received JSON response to retrieve the bot's answer.
/// In case of an error (e.g., network issues, JSON parsing problems, etc.),
/// the error is passed back through the completion handler.
///
/// - Parameters:
///   - question: The question for which you want a bot's response.
///   - completion: A closure to be executed once the fetch is complete.
///                 It receives two arguments: the bot's response (if successful)
///                 and an error (if any occurred).
///
/// - Returns: Void
///
func getBotResponse(question: String, completion: @escaping (String?, Error?) -> Void) {
    // Define the endpoint URL
    let url = URL(string: "http://127.0.0.1:5000/answer")!
    
    // Create a URLRequest object
    var request = URLRequest(url: url)
    
    // Specify the HTTP method
    request.httpMethod = "POST"
    
    // Set the request headers
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Convert the question string to JSON data and set it as the HTTP body
    let jsonData = try? JSONSerialization.data(withJSONObject: ["question": question])
    request.httpBody = jsonData
    
    // Create a data task to send the request and handle the response
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            // Handle error
            completion(nil, error)
            return
        }
        
        if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []), let dict = jsonObject as? [String: Any], let answer = dict["answer"] as? String {
            // Handle success
            completion(answer, nil)
        } else {
            completion(nil, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"]))
        }
    }
    
    // Start the task
    task.resume()
}

