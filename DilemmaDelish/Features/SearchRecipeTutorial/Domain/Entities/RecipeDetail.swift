//
//  RecipeDetail.swift
//  DilemmaDelish
//
//  Created by TORI on 6/10/24.
//

import Foundation

struct RecipeDetail {
    let categories: [Category]
    let ingredients: [Ingredient]
    let seasonings: [Seasoning]
    
    struct Category {
        let iconName: String
        let name: String
    }
    
    struct Ingredient {
        let iconName: String
        let name: String
        let quantity: String
    }
    
    struct Seasoning {
        let iconName: String
        let name: String
    }
}
