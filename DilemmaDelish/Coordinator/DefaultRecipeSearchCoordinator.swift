//
//  DefaultRecipeSearchCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

protocol RecipeSearchCoordinatorDependencies {
    func makeRecipeSearch() -> UIViewController
    func makeRecipeSearchResults(with query: String) -> UIViewController
    func makeRecipeSearchResultDetail(with id: String) -> UIViewController
}
