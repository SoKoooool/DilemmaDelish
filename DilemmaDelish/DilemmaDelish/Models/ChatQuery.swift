//
//  ChatQueryModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/23.
//

import Foundation

struct ChatQuery {
    let role: Role
    let message: String
    
    enum Role: String {
        case user
        case assistant
        case system
    }
}
