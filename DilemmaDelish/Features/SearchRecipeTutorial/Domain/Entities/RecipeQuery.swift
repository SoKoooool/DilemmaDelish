//
//  RecipeQuery.swift
//  DilemmaDelish
//
//  Created by TORI on 6/10/24.
//

import Foundation

struct RecipeQuery {
    let categories: [String]
    let ingredients: [String]
    let seasonings: [String]
    
    init(categories: [String], ingredients: [String], seasonings: [String]) {
        self.categories = categories
        self.ingredients = ingredients
        self.seasonings = seasonings
    }
    
    init(_ recipeDetail: RecipeDetail) {
        self.categories = recipeDetail.categories.map { $0.name }
        self.ingredients = recipeDetail.ingredients.map { $0.name }
        self.seasonings = recipeDetail.seasonings.map { $0.name }
    }
}
