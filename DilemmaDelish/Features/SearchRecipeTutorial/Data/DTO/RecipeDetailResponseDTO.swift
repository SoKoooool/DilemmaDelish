//
//  RecipeDetailResponseDTO.swift
//  DilemmaDelish
//
//  Created by TORI on 7/7/24.
//

import Foundation

struct RecipeDetailResponseDTO: Decodable {
    let categories: [Category]
    let ingredients: [Ingredient]
    let seasonings: [Seasoning]
    
    struct Category: Decodable {
        let name: String
        let iconName: String
    }
    
    struct Ingredient: Decodable {
        let name: String
        let iconName: String
        let quantity: String
    }

    struct Seasoning: Decodable {
        let name: String
        let iconName: String
    }
}
