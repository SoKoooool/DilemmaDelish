//
//  SearchRecipeRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation
import RxSwift

public final class DefaultSearchRecipeRepository: RecipeSearchRepository {
    func searchRecipe(from searchable: RecipeSearchable) -> Observable<[Recipe]> {
        return RecipeAPI().recipe(with: searchable.toQueryString())
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
