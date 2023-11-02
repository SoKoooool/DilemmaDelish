//
//  RecipeQueryMessage.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/11/02.
//

import Foundation

struct RecipeQueryMessage {
    let role: ChatQuery.Message.Role
    let content: String
    private let systemMessage = ChatQuery.Message(role: .system, content: "system")
    
    func toQuery() -> ChatQuery {
        let message = ChatQuery.Message(role: role, content: content)
        return ChatQuery(messages: [systemMessage, message])
    }
}
