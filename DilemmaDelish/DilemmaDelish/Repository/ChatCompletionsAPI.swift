//
//  ChatCompletionsAPI.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/16.
//

import Foundation
import RxSwift

final class ChatCompletionsAPI {
    
    static let shared = ChatCompletionsAPI()
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func chatCompletion(query: ChatQuery) -> Observable<Data> {
        do { return performRequest(try query.toRequest()) }
        catch { return .error(error) }
    }
    
    private func performRequest(_ request: URLRequest) -> Observable<Data> {
        return Observable.create { emitter in
            self.session.dataTask(request: request) { data, response, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    emitter.onCompleted()
                    return
                }
                print("Status Code: \(response.statusCode)")
                
                guard let data = data else {
                    emitter.onCompleted()
                    return
                }
                emitter.onNext(data)
                emitter.onCompleted()
            }.resume()
            return Disposables.create()
        }
    }
}
