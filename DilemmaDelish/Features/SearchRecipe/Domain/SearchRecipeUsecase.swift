//
//  SearchRecipeUsecase.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation

protocol SearchRecipeUsecase {
    func execute(query: String) -> [Recipe]
}

public final class DefaultSearchRecipeUsecase: SearchRecipeUsecase {
    
    private let repository: SearchRecipeRepository
    
    init(repository: SearchRecipeRepository) {
        self.repository = repository
    }
    
    func execute(query: String) -> [Recipe] {
        return repository.fetchRecipe(query: query)
    }
}
