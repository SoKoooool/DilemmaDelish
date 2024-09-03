//
//  SearchRecipeRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation
import RxSwift

protocol SearchRecipeRepository {
    func fetchRecipe(query: String) -> Observable<[Recipe]>
}

public final class DefaultSearchRecipeRepository: SearchRecipeRepository {
    func fetchRecipe(query: String) -> Observable<[Recipe]> {
        return RecipeAPI().recipe()
            .map { $0.dto.map { $0.toDomain() } }
    }
}

extension RecipeAPI.Recipe.Response.DTO {
    func toDomain() -> Recipe {
        return Recipe(name: name,
                      directions: directions,
                      ingredients: ingredients,
                      seasonings: seasonings)
    }
}
