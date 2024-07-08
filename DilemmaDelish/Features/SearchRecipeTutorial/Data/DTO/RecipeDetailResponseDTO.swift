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

extension RecipeDetailResponseDTO {
    func toDomain() -> RecipeDetail {
        return RecipeDetail(categories: categories.map { $0.toDomain() },
                            ingredients: ingredients.map { $0.toDomain() },
                            seasonings: seasonings.map { $0.toDomain() })
    }
}

extension RecipeDetailResponseDTO.Category {
    func toDomain() -> RecipeDetail.Category {
        return RecipeDetail.Category(iconName: iconName, name: name)
    }
}

extension RecipeDetailResponseDTO.Ingredient {
    func toDomain() -> RecipeDetail.Ingredient {
        return RecipeDetail.Ingredient(iconName: iconName, name: name, quantity: quantity)
    }
}

extension RecipeDetailResponseDTO.Seasoning {
    func toDomain() -> RecipeDetail.Seasoning {
        return RecipeDetail.Seasoning(iconName: iconName, name: name)
    }
}
