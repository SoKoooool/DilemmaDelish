//
//  ViewRecipeDetail.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation

struct ViewRecipeDetail {
    let categories: [Category]
    let ingredients: [Ingredient]
    let seasonings: [Seasoning]
    
    init(categories: [Category], ingredients: [Ingredient], seasonings: [Seasoning]) {
        self.categories = categories
        self.ingredients = ingredients
        self.seasonings = seasonings
    }
    
    init(_ recipeDetail: RecipeDetail) {
        self.categories = recipeDetail.categories.map { Category($0) }
        self.ingredients = recipeDetail.ingredients.map { Ingredient($0) }
        self.seasonings = recipeDetail.seasonings.map { Seasoning($0) }
    }
    
    struct Category {
        let name: String
        let iconName: String
        var isSelected: Bool = false
        
        init(_ recipeType: RecipeDetail.Category) {
            self.name = recipeType.name
            self.iconName = recipeType.iconName
        }
        
        init(name: String, iconName: String, isSelected: Bool) {
            self.name = name
            self.iconName = iconName
            self.isSelected = isSelected
        }
        
        func selected(state: Bool) -> Self {
            return Category(name: name, iconName: iconName, isSelected: state)
        }
    }

    struct Ingredient {
        let name: String
        let iconName: String
        var isSelected: Bool = false
        
        init(_ recipeIngredient: RecipeDetail.Ingredient) {
            self.name = recipeIngredient.name
            self.iconName = recipeIngredient.iconName
        }
    }

    struct Seasoning {
        let name: String
        let iconName: String
        var isSelected: Bool = false
        
        init(_ recipeSeasoning: RecipeDetail.Seasoning) {
            self.name = recipeSeasoning.name
            self.iconName = recipeSeasoning.iconName
        }
    }
}

extension ViewRecipeDetail {
    func asRecipeDetail() -> RecipeDetail {
        return RecipeDetail(categories: categories.map { RecipeDetail.Category(iconName: $0.iconName, name: $0.name) },
                            ingredients: ingredients.map { RecipeDetail.Ingredient(iconName: $0.iconName, name: $0.name) },
                            seasonings: seasonings.map { RecipeDetail.Seasoning(iconName: $0.iconName, name: $0.name) })
    }
}
