//
//  RecipeResponseDTO.swift
//  DilemmaDelish
//
//  Created by TORI on 7/8/24.
//

import Foundation

struct RecipeResponseDTO: Decodable {
    let name: String
    let directions: [String]
    let ingredients: [String]
    let seasonings: [String]
}
