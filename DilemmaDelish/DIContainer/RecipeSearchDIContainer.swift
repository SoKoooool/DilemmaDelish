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
    
    func makeRecipeSearchCoordinator() -> Coordinator {
        return DefaultRecipeSearchCoordinator(navigationController: navigationController, dependencies: self)
    }
}

// MARK: - ViewControllers Injection

extension RecipeSearchDIContainer {
    func makeRecipeSearchViewController(viewModel: RecipeSearchViewModel) -> UIViewController {
        return RecipeSearchViewController(viewModel: viewModel)
    }
    
    func makeRecipeSearchResultsViewController(viewModel: RecipeSearchResultsViewModel) -> UIViewController {
        return RecipeSearchResultsViewController(viewModel: viewModel)
    }
    
    func makeRecipeSearchResultDetailViewController(viewModel: RecipeSearchResultDetailViewModel) -> UIViewController {
        return RecipeSearchResultDetailViewController(viewModel: viewModel)
    }
}

// MARK: - ViewModels Injection

extension RecipeSearchDIContainer {
    func makeRecipeSearchViewModel(coordinator: RecipeSearchCoordinator) -> RecipeSearchViewModel {
        return DefaultRecipeSearchViewModel(coordinator: coordinator)
    }

    func makeRecipeSearchResultsViewModel(coordinator: RecipeSearchCoordinator) -> RecipeSearchResultsViewModel {
        let repository = DefaultRecipeSearchRepository()
        let usecase = DefaultRecipeSearchUsecase(repository: repository)
        return DefaultRecipeSearchResultsViewModel(recipeSearchUsecase: usecase, coordinator: coordinator)
    }
    
    func makeRecipeSearchResultDetailViewModel(coordinator: RecipeSearchCoordinator) -> RecipeSearchResultDetailViewModel {
        let repository = DefaultRecipeSearchRepository()
        let usecase = DefaultRecipeSearchUsecase(repository: repository)
        return DefaultRecipeSearchResultDetailViewModel(recipeSearchUsecase: usecase)
    }
}
