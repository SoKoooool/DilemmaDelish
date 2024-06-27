//
//  ViewRecipeDetail.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation

struct ViewRecipeDetail {
    let types: [ViewRecipeType]
    let mainIngredients: [ViewRecipeIngredient]
    let subIngredients: [ViewRecipeIngredient]
    
    init(_ recipeDetail: RecipeDetail) {
        self.types = recipeDetail.recipeTypes.map { ViewRecipeType($0) }
        self.mainIngredients = recipeDetail.mainIngredients.map { ViewRecipeIngredient($0) }
        self.subIngredients = recipeDetail.subIngredients.map { ViewRecipeIngredient($0) }
    }
}

struct ViewRecipeType {
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
        return ViewRecipeType(name: name, iconName: iconName, isSelected: state)
    }
}

struct ViewRecipeIngredient {
    let name: String
    let iconName: String
    let quantity: String
    
    init(_ recipeIngredient: RecipeDetail.Ingredient) {
        self.name = recipeIngredient.name
        self.iconName = recipeIngredient.iconName
        self.quantity = recipeIngredient.quantity
    }
}

