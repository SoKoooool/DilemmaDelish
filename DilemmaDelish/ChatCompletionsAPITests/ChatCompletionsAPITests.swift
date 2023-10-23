//
//  ChatCompletionsAPITests.swift
//  ChatCompletionsAPITests
//
//  Created by TORI on 2023/10/16.
//

import XCTest
@testable import DilemmaDelish

final class ChatCompletionsAPITests: XCTestCase {

    var gpt: ChatCompletionsAPI!
    var session: MockURLSession!
    
    override func setUpWithError() throws {
        session = MockURLSession()
        gpt = ChatCompletionsAPI(session: session)
    }

    override func tearDownWithError() throws {
        session = nil
        gpt = nil
    }

    func test_ChatCompletionsAPI_성공_확인() throws {
        let message: ChatResponseModel.Choice.Message = .init(role: "system", content: "Response Message")
        let choices: [ChatResponseModel.Choice] = [.init(index: 0, message: message, finishReason: "finishReason")]
        let usage: ChatResponseModel.Usage = .init(promptTokens: 0, completionTokens: 0, totalTokens: 0)
        let responseModel = ChatResponseModel(id: "id",
                                     object: "object",
                                     model: "gpt-3.5-turbo",
                                     created: 0,
                                     choices: choices,
                                     usage: usage)
        let data = try JSONEncoder().encode(responseModel)
        session.response = .successDataTask(with: data)
        
        let query = ChatQueryModel(role: .user, message: "Request Message")
        let request = gpt.createRequest(from: query.toRequestModel())!
        
        gpt.performRequest(request) { result in
            guard case let .success(success) = result else { return }
            XCTAssertEqual(success, data)
        }
    }
    
    func test_ChatCompletionAPI_실패_확인() {
        let error = NSError(domain: "Request Error", code: -1)
        session.response = .failureDataTask(with: error)
        
        let query = ChatQueryModel(role: .user, message: "Request Message")
        let request = gpt.createRequest(from: query.toRequestModel())!
        
        gpt.performRequest(request) { result in
            guard case let .failure(failure) = result else { return }
            XCTAssertEqual(failure, error)
        }
    }
}
