//
//  Requestable.swift
//  DilemmaDelish
//
//  Created by TORI on 8/19/24.
//

import Foundation

public protocol Requestable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
