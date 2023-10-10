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
        
        sut.storeIngredient(item: item)
        guard case let .success(result) = sut.fetchIngredients() else { return }
        
        XCTAssertEqual(result.last!.name, item.name)
        XCTAssertEqual(result.last!.imageName, item.imageName)
    }
    
    func test_재료가_하나_삭제되는지_확인() {
        let item = IngredientItem(name: "삭제대상", imageName: "삭제대상")
        
        sut.deleteAllIngredients()
        sut.storeIngredient(item: item)
        sut.deleteIngredient(item: item)
        guard case let .success(result) = sut.fetchIngredients() else { return }
        
        XCTAssertFalse(result.contains { item.name == $0.name })
    }
    
    func test_재료가_모두_삭제되는지_확인() {
        sut.deleteAllIngredients()
        
        guard case let .success(result) = sut.fetchIngredients() else { return }
        
        XCTAssertEqual(result.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
