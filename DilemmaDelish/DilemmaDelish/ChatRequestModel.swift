//
//  ChatRequestModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

struct ChatRequestModel: Encodable {
    let model: String
    let messages: [Message]
    
    struct Message: Encodable {
        let role, content: String
    }
}
