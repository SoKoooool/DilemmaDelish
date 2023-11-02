//
//  GPTResponseModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

struct ChatResponse: Codable {
    let id, object, model: String
    let created: Int
    let choices: [Choice]
    let usage: Usage
    
    struct Choice: Codable {
        let index: Int
        let message: Message
        let finishReason: String
        
        enum CodingKeys: String, CodingKey {
            case index, message
            case finishReason = "finish_reason"
        }
        
        struct Message: Codable {
            let role, content: String
        }
    }
    
    struct Usage: Codable {
        let promptTokens, completionTokens, totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
    
    func toRecipeItems() throws -> [RecipeItem] {
        let jsonString = choices.first?.message.content
        let data = jsonString?.data(using: .utf8)
        return try JSONDecoder().decode([RecipeItem].self, from: data ?? Data())
    }
}
