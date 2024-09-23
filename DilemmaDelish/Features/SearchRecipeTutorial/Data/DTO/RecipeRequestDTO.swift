//
//  RecipeRequestDTO.swift
//  DilemmaDelish
//
//  Created by TORI on 7/8/24.
//

import Foundation

struct RecipeRequestDTO: Encodable {
    let query: String
    
    init(_ query: String) {
        self.query = query
    }
    
    init(_ recipeQuery: RecipeQuery) {
        let categoriesString = recipeQuery.categories.joined(separator: ",")
        let ingredientsString = recipeQuery.ingredients.joined(separator: ",")
        let seasoningsString = recipeQuery.seasonings.joined(separator: ",")
        self.query = categoriesString + ingredientsString + seasoningsString
    }
}
