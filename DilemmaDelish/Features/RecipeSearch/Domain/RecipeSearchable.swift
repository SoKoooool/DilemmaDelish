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

public final class DefaultRecipeSearchable: RecipeSearchable {
    var name: String
    var categories: [String]?
    var ingredients: [String]?
    var seasonings: [String]?
    var cuisineType: String?
    var dietaryRestrictions: [String]?
    var preparationTime: Int?
    var cookingTime: Int?
    var difficulty: String?
    var mealType: String?
    var cookingMethod: String?
    var occasion: String?
    var taste: [String]?
    
    init(name: String, categories: [String]? = nil, ingredients: [String]? = nil, seasonings: [String]? = nil, cuisineType: String? = nil, dietaryRestrictions: [String]? = nil, preparationTime: Int? = nil, cookingTime: Int? = nil, difficulty: String? = nil, mealType: String? = nil, cookingMethod: String? = nil, occasion: String? = nil, taste: [String]? = nil) {
        self.name = name
        self.categories = categories
        self.ingredients = ingredients
        self.seasonings = seasonings
        self.cuisineType = cuisineType
        self.dietaryRestrictions = dietaryRestrictions
        self.preparationTime = preparationTime
        self.cookingTime = cookingTime
        self.difficulty = difficulty
        self.mealType = mealType
        self.cookingMethod = cookingMethod
        self.occasion = occasion
        self.taste = taste
    }
}
