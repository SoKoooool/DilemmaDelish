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

extension MockURLDataTask {
    
    static func successDataTask(with data: Data) -> MockURLDataTask {
        let response = HTTPURLResponse(url: URL(string: "url")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        let task = MockURLDataTask(data: data, response: response)
        return task
    }
    
    static func failureDataTask(with error: Error) -> MockURLDataTask {
        let response = HTTPURLResponse(url: URL(string: "url")!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: nil)
        let task = MockURLDataTask(response: response, error: error)
        return task
    }
}
