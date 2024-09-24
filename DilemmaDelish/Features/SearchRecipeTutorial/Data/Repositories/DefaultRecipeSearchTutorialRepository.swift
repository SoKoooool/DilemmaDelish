//
//  DefaultRecipeSearchTutorialRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 9/24/24.
//

import Foundation
import RxSwift

public final class DefaultRecipeSearchTutorialRepository: RecipeSearchTutorialRepository {
    func fetchRecipeDetail() -> Observable<RecipeDetail> {
        return RecipeAPI().recipeDetail()
            .map { $0.toDomain() }
    }
}

extension RecipeAPI.RecipeDetail.Response {
    func toDomain() -> RecipeDetail {
        return RecipeDetail(categories: response.map { RecipeDetail.Category(iconName: $0, name: $0) },
                            ingredients: response.map { RecipeDetail.Ingredient(iconName: $0, name: $0) },
                            seasonings: response.map { RecipeDetail.Seasoning(iconName: $0, name: $0) })
    }
}
