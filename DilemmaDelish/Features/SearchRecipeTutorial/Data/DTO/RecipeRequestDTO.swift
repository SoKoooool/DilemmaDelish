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
        let categoryString = recipeQuery.category
        let ingredientsString = recipeQuery.ingredients.joined(separator: ",")
        let seasoningsString = recipeQuery.seasonings.joined(separator: ",")
        self.query = categoryString + ingredientsString + seasoningsString
    }
}
