//
//  RecipeSearchService.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/30.
//

import Foundation
import RxSwift

protocol RecipeSearchServiceProtocol {

}

final class RecipeSearchService: RecipeSearchServiceProtocol {
    
    private let repository: RepositoryProtocol!
    
    init(repository: RepositoryProtocol! = PersistentStorage()) {
        self.repository = repository
    }
}
