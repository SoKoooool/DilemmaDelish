//
//  RecipeSearchable.swift
//  DilemmaDelish
//
//  Created by TORI on 9/30/24.
//

import Foundation

protocol RecipeSearchable {
    var name: String { get }
    var categories: [String]? { get }
    var ingredients: [String]? { get }
    var seasonings: [String]? { get }
    var cuisineType: String? { get }
    var dietaryRestrictions: [String]? { get }
    var preparationTime: Int? { get }
    var cookingTime: Int? { get }
    var difficulty: String? { get }
    var mealType: String? { get }
    var cookingMethod: String? { get }
    var occasion: String? { get }
    var taste: [String]? { get }
}
