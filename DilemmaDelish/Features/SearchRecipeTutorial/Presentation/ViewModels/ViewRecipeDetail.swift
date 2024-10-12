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
    
    init(_ updated: (categories: [Category], ingredient: [Ingredient], seasonings: [Seasoning])) {
        self.categories = updated.categories
        self.ingredients = updated.ingredient
        self.seasonings = updated.seasonings
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
    func toQuery() -> String {
        let categoryNames = "[categories:\(categories.map { $0.name }.joined(separator: ","))],"
        let ingredientNames = "[ingredients:\(ingredients.map { $0.name }.joined(separator: ","))],"
        let seasoningNames = "[seasonings:\(seasonings.map { $0.name }.joined(separator: ","))]"
        return categoryNames + ingredientNames + seasoningNames
    }
}

extension ViewRecipeDetail {
    func filteredSelection() -> ViewRecipeDetail {
        return ViewRecipeDetail(categories: categories.filter { $0.isSelected },
                                ingredients: ingredients.filter { $0.isSelected },
                                seasonings: seasonings.filter { $0.isSelected })
    }
}
