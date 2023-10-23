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
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    var completion: (Data?, URLResponse?, Error?) -> Void
    
    init(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completion
    }
    
    func resume() {
        completion(data, response, error)
    }
}
