//
//  RecipeSearchTutorialCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

protocol RecipeSearchTutorialCoordinatorDependencies {
    func makeCategoriesPickerViewController(viewModel: RecipeSearchTutorialViewModel) -> UIViewController
    func makeIngredientsPickerViewController(viewModel: RecipeSearchTutorialViewModel) -> UIViewController
    func makeSeasoningsPickerViewController(viewModel: RecipeSearchTutorialViewModel) -> UIViewController
    func makeRecipeSearchTutorialViewModel(coordinator: RecipeSearchTutorialCoordinator) -> RecipeSearchTutorialViewModel
}

public final class RecipeSearchTutorialCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    var onFinish: ((String) -> Void)?
    
    private let dependencies: RecipeSearchTutorialCoordinatorDependencies
    
    private lazy var viewModel: RecipeSearchTutorialViewModel = {
        dependencies.makeRecipeSearchTutorialViewModel(coordinator: self)
    }()
    
    init(navigationController: UINavigationController?, 
         dependencies: RecipeSearchTutorialCoordinatorDependencies = Container.shared.resolve(RecipeSearchTutorialDIContainer.self)) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showCategoriesPicker()
    }
    
    func showCategoriesPicker() {
        let viewController = dependencies.makeCategoriesPickerViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showIngredientsPicker() {
        let viewController = dependencies.makeCategoriesPickerViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSeasoningsPicker() {
        let viewController = dependencies.makeCategoriesPickerViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didFinishCoordinate(with query: String) {
        onFinish?(query)
    }
}
