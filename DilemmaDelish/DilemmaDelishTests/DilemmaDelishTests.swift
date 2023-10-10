//
//  DilemmaDelishTests.swift
//  DilemmaDelishTests
//
//  Created by TORI on 2023/09/27.
//

import XCTest
@testable import DilemmaDelish

final class DilemmaDelishTests: XCTestCase {

    var sut: PersistentStorage!
    
    override func setUpWithError() throws {
        sut = PersistentStorage.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_재료가_저장되는지_확인() {
        let item = IngredientItem(name: "테스트재료", imageName: "테스트이미지")
        
        sut.store(item: item)
        let fetchResult = sut.fetchIngredients()
        guard case let .success(result) = fetchResult else { return }
        
        XCTAssertEqual(result.last!.name, item.name)
        XCTAssertEqual(result.last!.imageName, item.imageName)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
