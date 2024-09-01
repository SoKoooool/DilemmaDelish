//
//  APIBase.swift
//  DilemmaDelish
//
//  Created by TORI on 8/19/24.
//

import Foundation
import RxSwift

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case httpError(statusCode: Int)
}

public protocol APIBase {
    var baseURL: String { get }
    var session: URLSession { get }
    func request<T: Requestable>(_ request: T) -> Observable<T.Response>
}

extension APIBase {
    func request<T: Requestable>(_ request: T) -> Observable<T.Response> {
        return Observable.create { emitter in
            self.request(request) { result in
                switch result {
                case let .success(data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func request<T: Requestable>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        guard let url = URL(string: baseURL + request.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let parameters = request.parameters {
            if request.method == .get {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                urlRequest.url = components?.url
            } else {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.httpError(statusCode: 0)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.httpError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}




