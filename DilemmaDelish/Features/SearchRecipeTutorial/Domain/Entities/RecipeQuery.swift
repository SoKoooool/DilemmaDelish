//
//  RecipeQuery.swift
//  DilemmaDelish
//
//  Created by TORI on 6/10/24.
//

import Foundation

struct RecipeQuery {
    let category: String
    let ingredients: [String]
    let seasonings: [String]
    
    init(category: String, ingredients: [String], seasonings: [String]) {
        self.category = category
        self.ingredients = ingredients
        self.seasonings = seasonings
    }
    
    init(_ recipeDetail: (category: String, ingredients: [String], seasonings: [String])) {
        self.category = recipeDetail.category
        self.ingredients = recipeDetail.ingredients
        self.seasonings = recipeDetail.seasonings
    }
}
