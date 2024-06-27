//
//  RecipeDetail.swift
//  DilemmaDelish
//
//  Created by TORI on 6/10/24.
//

import Foundation

struct RecipeDetail {
    let recipeTypes: [Category]
    let mainIngredients: [Ingredient]
    let additionalIngredients: [Ingredient]
    
    struct Category {
        let iconName: String
        let name: String
    }
    
    struct Ingredient {
        let iconName: String
        let name: String
        let quantity: String
    }
}
