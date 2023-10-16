//
//  GPTModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation

enum GPTModel {
    case gpt_3_5_turbo
    case gpt_4
    
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
