//
//  ChatCompletionsAPI.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

final class ChatCompletionsAPI {
    
    private let apiKey = ""
    
    func createChatCompletion(with request: URLRequest, completion: @escaping (Result<Data, NSError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error as NSError))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "InvalidResponse", code: -2)
                completion(.failure(error))
                print(error._domain)
                return
            }
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                let error = NSError(domain: "NoData", code: -1)
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
    }
    
    func createRequest(from model: ChatRequestModel) -> URLRequest? {
        let url = URL(string: GPTModel.gpt_3_5_turbo.endpoint)!
        var request = URLRequest(url: url)
        guard let requestBody = try? JSONEncoder().encode(model) else { return nil }
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = requestBody
        return request
    }
}
