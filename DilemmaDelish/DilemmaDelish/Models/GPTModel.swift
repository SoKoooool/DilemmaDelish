//
//  GPTModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

enum GPTModel: String, Encodable {
    case gpt_3_5_turbo = "gpt-3.5-turbo"
    case gpt_4 = "gpt-4"
    
    var endpoint: String {
        let endpoint: String
        switch self {
        case .gpt_3_5_turbo:
            endpoint = "https://api.openai.com/v1/chat/completions"
        case .gpt_4:
            endpoint = "https://api.openai.com/v1/chat/completions"
        }
        return endpoint
    }
}
