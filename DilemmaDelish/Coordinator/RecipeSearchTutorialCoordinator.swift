//
//  RecipeSearchTutorialCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

protocol RecipeSearchTutorialCoordinator {
    func showCategoriesPicker()
    func showIngredientsPicker()
    func showSeasoningsPicker()
    func didFinishCoordinate(with query: String)
}

protocol RecipeSearchTutorialCoordinatorDependencies {
    func makeCategoriesPickerViewController() -> UIViewController
    func makeIngredientsPickerViewController() -> UIViewController
    func makeSeasoningsPickerViewController() -> UIViewController
}

public final class DefaultRecipeSearchTutorialCoordinator: RecipeSearchTutorialCoordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    var onFinish: ((String) -> Void)?
    
    private let dependencies: RecipeSearchTutorialCoordinatorDependencies
    
    init(navigationController: UINavigationController?, 
         dependencies: RecipeSearchTutorialCoordinatorDependencies = Container.shared.resolve(RecipeSearchTutorialDIContainer.self)) {
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
    
    func didFinishCoordinate(with query: String) {
        onFinish?(query)
    }
}
