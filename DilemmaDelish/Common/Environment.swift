//
//  Environment.swift
//  DilemmaDelish
//
//  Created by TORI on 7/16/24.
//

import Foundation

struct Environment {
    static var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    static var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
