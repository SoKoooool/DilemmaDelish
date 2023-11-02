//
//  ChatRequestModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

struct ChatQuery: Encodable {
    let model: Model
    let messages: [Message]
    
    init(model: Model = .gpt3_5turbo, messages: [Message]) {
        self.model = model
        self.messages = messages
    }
    
    enum Model: String, Encodable {
        case gpt3_5turbo = "gpt-3.5-turbo"
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
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        let body = try JSONEncoder().encode(self)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer apiKey", forHTTPHeaderField: "Authorization")
        request.httpBody = body
        return request
    }

}
