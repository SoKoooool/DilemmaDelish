//
//  RecipeSearchTutorialDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

public final class RecipeSearchTutorialDIContainer: RecipeSearchTutorialCoordinatorDependencies {
    func makeCoordinator(navigationController: UINavigationController?) -> RecipeSearchTutorialCoordinator {
        return DefaultRecipeSearchTutorialCoordinator(navigationController: navigationController)
    }
    
    func makeCategoriesPickerViewController() -> UIViewController {
        return RecipeCategoriesPickerViewController()
    }
    
    func makeIngredientsPickerViewController() -> UIViewController {
        return RecipeIngredientsPickerViewController()
    }
    
    func makeSeasoningsPickerViewController() -> UIViewController {
        RecipeSeasoningsPickerViewController()
    }
}
