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
}

struct ViewRecipeType {
    let name: String
    let iconName: String
}

struct ViewRecipeIngredient {
    let name: String
    let iconName: String
    let quantity: String
}

