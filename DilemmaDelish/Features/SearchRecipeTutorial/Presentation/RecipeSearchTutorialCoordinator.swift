//
//  RecipeSearchTutorialCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

protocol RecipeSearchTutorialCoordinatorDependencies {
    func makeCategoriesPickerViewController() -> UIViewController
    func makeIngredientsPickerViewController() -> UIViewController
    func makeSeasoningsPickerViewController() -> UIViewController
}

public final class RecipeSearchTutorialCoordinator {
    
    private let navigationController: UINavigationController?
    private let dependencies: RecipeSearchTutorialCoordinatorDependencies
    
    init(navigationController: UINavigationController?, dependencies: RecipeSearchTutorialCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showCategoriesPicker()
    }
    
    func showCategoriesPicker() {
        let viewController = dependencies.makeCategoriesPickerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showIngredientsPicker() {
        let viewController = dependencies.makeCategoriesPickerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSeasoningsPicker() {
        let viewController = dependencies.makeCategoriesPickerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
