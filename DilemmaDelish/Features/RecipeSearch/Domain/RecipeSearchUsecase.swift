//
//  SearchRecipeUsecase.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation
import RxSwift

protocol RecipeSearchUsecase {
    func execute(_ query: String) -> Observable<[Recipe]>
}

public final class DefaultRecipeSearchUsecase: RecipeSearchUsecase {
    
    private let repository: RecipeSearchRepository
    
    init(repository: RecipeSearchRepository = Container.shared.resolve(DefaultRecipeSearchRepository.self)) {
        self.repository = repository
    }
    
    func execute(_ query: String) -> Observable<[Recipe]> {
        return repository.searchRecipe(query)
    }
}
