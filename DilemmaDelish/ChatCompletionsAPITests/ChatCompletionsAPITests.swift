//
//  ChatCompletionsAPITests.swift
//  ChatCompletionsAPITests
//
//  Created by TORI on 2023/10/16.
//

import XCTest
@testable import DilemmaDelish

final class ChatCompletionsAPITests: XCTestCase {

    var sut: ChatCompletionsAPI!
    
    override func setUpWithError() throws {
        sut = ChatCompletionsAPI()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_리퀘스트가_제대로_생성되는지_확인() {
        
    }
    
    func test_POST_메서드가_요청한_데이터를_받아오는지_확인() {
        let model = ChatRequestModel(model: "gpt-3.5-turbo", messages: [ChatRequestModel.Message(role: "user", content: "안녕하세요")])
        let request = sut.createRequest(from: model)!
        
        sut.performRequest(request) { result in
            switch result {
            case let .success(data):
                guard let decodedData = try? JSONDecoder().decode(GPTResponseModel.self, from: data) else { return }
                XCTAssertTrue(decodedData.choices.contains(where: {
                    $0.message.content == "안녕하세요"
                }))
            case let .failure(error):
                XCTFail("\(error)")
            }
        }
    }

}
