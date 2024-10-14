//
//  RecipeSearchCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

protocol RecipeSearchCoordinator {
    func showRecipeSearch()
    func showRecipeSearchResults(with query: String)
    func showRecipeSearchResultDetail(with id: String)
}
