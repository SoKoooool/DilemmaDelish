//
//  MockURLDataTask.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

final class MockURLDataTask: URLSessionDataTaskProtocol {
    
    private let data: Data?
    private let response: URLResponse?
    private let error: Error?
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    init(data: Data? = nil,
         response: URLResponse?,
         error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func resume() {
        completion?(data, response, error)
    }
}
