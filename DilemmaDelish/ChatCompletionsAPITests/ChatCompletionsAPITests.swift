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
    
    func test_포스트_네트워킹이_요청한_데이터를_받아오는지_확인() {
        
    }

}
