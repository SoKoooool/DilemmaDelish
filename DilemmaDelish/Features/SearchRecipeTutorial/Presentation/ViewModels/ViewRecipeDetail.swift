//
//  ViewRecipeDetail.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation

struct ViewRecipeDetail {
    let categories: [ViewRecipeCategory]
    let ingredients: [ViewRecipeIngredient]
    let seasonings: [ViewRecipeSeasoning]
    
    init(_ recipeDetail: RecipeDetail) {
        self.categories = recipeDetail.categories.map { ViewRecipeCategory($0) }
        self.ingredients = recipeDetail.ingredients.map { ViewRecipeIngredient($0) }
        self.seasonings = recipeDetail.seasonings.map { ViewRecipeSeasoning($0) }
    }
}

struct ViewRecipeCategory {
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
        return ViewRecipeCategory(name: name, iconName: iconName, isSelected: state)
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

struct ViewRecipeSeasoning {
    let name: String
    let iconName: String
    
    init(_ recipeSeasoning: RecipeDetail.Seasoning) {
        self.name = recipeSeasoning.name
        self.iconName = recipeSeasoning.iconName
    }
}
