//
//  ChatQueryModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/23.
//

import Foundation

struct ChatQueryModel {
    let role: Role
    let message: String
    
    enum Role: String {
        case user
        case assistant
        case system
    }
    
    func toRequestModel() -> ChatRequestModel {
        let message = ChatRequestModel.Message(role: role.rawValue, content: message)
        let model = ChatRequestModel(model: GPTModel.gpt_3_5_turbo.rawValue, messages: [message])
        return model
    }
}
