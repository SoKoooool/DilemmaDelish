//
//  RecipeItem.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/30.
//

import Foundation

struct RecipeItem {
    let name: String
    let imageString: String
    let ingredients: [IngredientItem]
    let description: String
    let instrictions: [String]
    let cookingTime: Int
    let difficulty: Int
}
