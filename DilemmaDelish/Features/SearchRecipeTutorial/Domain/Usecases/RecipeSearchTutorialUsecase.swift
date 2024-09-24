//
//  RecipeSearchTutorialUsecase.swift
//  DilemmaDelish
//
//  Created by TORI on 9/24/24.
//

import Foundation
import RxSwift

protocol RecipeSearchTutorialUsecase {
    func execute() -> Observable<RecipeDetail>
}

public final class DefaultRecipeSearchTutorialUsecase: RecipeSearchTutorialUsecase {
    
    private let repository: RecipeSearchTutorialRepository
    
    init(repository: RecipeSearchTutorialRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<RecipeDetail> {
        return repository.fetchRecipeDetail()
    }
}
