//
//  RecipeSearchService.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/30.
//

import Foundation
import RxSwift

protocol RecipeSearchServiceProtocol {
    func fetchIngredients() -> Observable<[IngredientItem]>
    func store(item: IngredientItem)
    func remove(item: IngredientItem)
}

final class RecipeSearchService: RecipeSearchServiceProtocol {
    
    private let repository: RepositoryProtocol!
    
    init(repository: RepositoryProtocol! = PersistentStorage()) {
        self.repository = repository
    }
    
    func fetchIngredients() -> Observable<[IngredientItem]> {
        return repository.readEntities()
            .map { $0.map { $0.toDomain() } }
    }
    
    func store(item: IngredientItem) {
        repository.create(item: item)
    }
    
    func remove(item: IngredientItem) {
        repository.delete(item: item)
    }
}
