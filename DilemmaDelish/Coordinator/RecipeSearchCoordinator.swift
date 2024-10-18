//
//  RecipeSearchCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

protocol RecipeSearchCoordinator: Coordinator {
    func showRecipeSearch()
    func showRecipeSearchResults(from searchable: RecipeSearchable)
    func showRecipeSearchResultDetail(with id: String)
}

protocol RecipeSearchCoordinatorDependencies {
    func makeRecipeSearchViewController(viewModel: RecipeSearchViewModel) -> UIViewController
    func makeRecipeSearchResultsViewController(viewModel: RecipeSearchResultsViewModel) -> UIViewController
    func makeRecipeSearchResultDetailViewController(viewModel: RecipeSearchResultDetailViewModel) -> UIViewController
    func makeRecipeSearchViewModel(coordinator: RecipeSearchCoordinator) -> RecipeSearchViewModel
    func makeRecipeSearchResultsViewModel(coordinator: RecipeSearchCoordinator) -> RecipeSearchResultsViewModel
    func makeRecipeSearchResultDetailViewModel(coordinator: RecipeSearchCoordinator) -> RecipeSearchResultDetailViewModel
}

public final class DefaultRecipeSearchCoordinator: RecipeSearchCoordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    
    private let dependencies: RecipeSearchCoordinatorDependencies
    
    init(navigationController: UINavigationController?, 
         dependencies: RecipeSearchCoordinatorDependencies = Container.shared.resolve(RecipeSearchDIContainer.self)) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showRecipeSearch()
    }
}

extension DefaultRecipeSearchCoordinator {
    func showRecipeSearch() {
        let viewModel = dependencies.makeRecipeSearchViewModel(coordinator: self)
        let viewController = dependencies.makeRecipeSearchViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipeSearchResults(from searchable: RecipeSearchable) {
        let viewModel = dependencies.makeRecipeSearchResultsViewModel(coordinator: self)
        let viewController = dependencies.makeRecipeSearchResultsViewController(viewModel: viewModel)
        viewModel.searchableRecipe.onNext(searchable)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipeSearchResultDetail(with id: String) {
        let viewModel = dependencies.makeRecipeSearchResultDetailViewModel(coordinator: self)
        let viewController = dependencies.makeRecipeSearchResultDetailViewController(viewModel: viewModel)
        viewModel.recipeName.onNext(id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
