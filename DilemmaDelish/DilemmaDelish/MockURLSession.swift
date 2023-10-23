//
//  MockURLSession.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/23.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}
