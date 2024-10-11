//
//  RecipeSearchTutorialDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

public final class RecipeSearchTutorialDIContainer: RecipeSearchTutorialCoordinatorDependencies {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeRecipeSearchTutorialCoordinator() -> RecipeSearchTutorialCoordinator {
        return RecipeSearchTutorialCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeCategoriesPickerViewController(viewModel: RecipeSearchTutorialViewModel) -> UIViewController {
        return RecipeCategoriesPickerViewController(viewModel: viewModel)
    }
    
    func makeIngredientsPickerViewController(viewModel: RecipeSearchTutorialViewModel) -> UIViewController {
        return RecipeIngredientsPickerViewController(viewModel: viewModel)
    }
    
    func makeSeasoningsPickerViewController(viewModel: RecipeSearchTutorialViewModel) -> UIViewController {
        RecipeSeasoningsPickerViewController(viewModel: viewModel)
    }
    
    func makeRecipeSearchTutorialViewModel(coordinator: RecipeSearchTutorialCoordinator) -> RecipeSearchTutorialViewModel {
        let repository = DefaultRecipeSearchTutorialRepository()
        let usecase = DefaultRecipeSearchTutorialUsecase(repository: repository)
        return DefaultRecipeSearchTutorialViewModel(recipeSearchTutorialUsecase: usecase)
    }
}
