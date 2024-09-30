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

extension RecipeSearchable {
    func toQueryString() -> String {
        var query = [String]()
        query.append("name=\(name)")
        
        guard let categories = categories, !categories.isEmpty,
              let ingredients = ingredients, !ingredients.isEmpty,
              let seasonings = seasonings, !seasonings.isEmpty,
              let cuisineType = cuisineType,
              let dietaryRestrictions = dietaryRestrictions,
              let preparationTime = preparationTime,
              let cookingTime = cookingTime,
              let difficulty = difficulty,
              let mealType = mealType,
              let cookingMethod = cookingMethod,
              let occasion = occasion,
              let taste = taste, !taste.isEmpty
        else { return query.joined(separator: ",")}
        
        query.append("categories=" + categories.joined(separator: ","))
        query.append("ingredients=" + ingredients.joined(separator: ","))
        query.append("seasonings=" + seasonings.joined(separator: ","))
        query.append("cuisineType=" + cuisineType)
        query.append("dietaryRestrictions=" + dietaryRestrictions.joined(separator: ","))
        query.append("preparationTime=\(preparationTime)")
        query.append("cookingTime=\(cookingTime)")
        query.append("difficulty=" + difficulty)
        query.append("mealType=" + mealType)
        query.append("cookingMethod=" + cookingMethod)
        query.append("occasion=" + occasion)
        query.append("taste=" + taste.joined(separator: ","))
        
        return query.joined(separator: "&")
    }
}
