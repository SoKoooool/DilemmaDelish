//
//  SearchRecipeUsecase.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation
import RxSwift

protocol RecipeSearchUsecase {
    func execute(from searchable: RecipeSearchable) -> Observable<[Recipe]>
}

public final class DefaultRecipeSearchUsecase: RecipeSearchUsecase {
    
    private let repository: RecipeSearchRepository
    
    init(repository: RecipeSearchRepository) {
        self.repository = repository
    }
    
    func execute(from searchable: RecipeSearchable) -> Observable<[Recipe]> {
        return repository.searchRecipe(query: searchable.toQueryString())
    }
}
