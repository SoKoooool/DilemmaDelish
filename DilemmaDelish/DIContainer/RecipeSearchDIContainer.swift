//
//  RecipeSearchDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

public final class RecipeSearchDIContainer: RecipeSearchCoordinatorDependencies {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeRecipeSearch() -> UIViewController {
        return UIViewController()
    }
    
    func makeRecipeSearchResults(with query: String) -> UIViewController {
        return UIViewController()
    }
    
    func makeRecipeSearchResultDetail(with id: String) -> UIViewController {
        return UIViewController()
    }
}
