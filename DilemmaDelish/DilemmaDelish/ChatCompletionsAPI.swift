//
//  ChatCompletionsAPI.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

final class ChatCompletionsAPI {
    
    private let apiKey = ""
    
    func createChatCompletion() {
        
    }
    
    private func createChatRequest(with question: String) -> URLRequest {
        let url = URL(string: GPTModel.gpt_3_5_turbo.endpoint)!
        var request = URLRequest(url: url)
        guard let requestBody = try? JSONSerialization.data(withJSONObject: ["question": question]) else { return }
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = requestBody
        return request
    }
}
