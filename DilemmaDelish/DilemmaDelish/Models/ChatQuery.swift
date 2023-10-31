//
//  ChatRequestModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

struct ChatQuery: Encodable {
    let model: GPTModel
    let messages: [Message]
    
    init(model: GPTModel = .gpt_3_5_turbo, messages: [Message]) {
        self.model = model
        self.messages = messages
    }
    
    struct Message: Encodable {
        let role: Role
        let content: String
        
        enum Role: String, Encodable{
            case assistant
            case system
            case user
        }
    }
    
    func toRequest() throws -> URLRequest {
        let url = URL(string: model.endpoint)!
        var request = URLRequest(url: url)
        let body = try JSONEncoder().encode(self)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer apiKey", forHTTPHeaderField: "Authorization")
        request.httpBody = body
        return request
    }

}
