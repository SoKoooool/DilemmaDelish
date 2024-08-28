//
//  SearchRecipeRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 8/28/24.
//

import Foundation

protocol SearchRecipeRepository {
    func fetchRecipe(query: String) -> [Recipe]
}


