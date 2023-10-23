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

}
