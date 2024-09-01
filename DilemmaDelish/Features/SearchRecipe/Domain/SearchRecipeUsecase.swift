//
//  SearchRecipeUsecase.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation
import RxSwift

protocol SearchRecipeUsecase {
    func execute(query: String) -> Observable<[Recipe]>
}

public final class DefaultSearchRecipeUsecase: SearchRecipeUsecase {
    
    private let repository: SearchRecipeRepository
    
    init(repository: SearchRecipeRepository) {
        self.repository = repository
    }
    
    func execute(query: String) -> Observable<[Recipe]> {
        return repository.fetchRecipe(query: query)
    }
}
