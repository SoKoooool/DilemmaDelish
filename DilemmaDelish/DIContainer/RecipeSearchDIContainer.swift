//
//  RecipeSearchDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

public final class RecipeSearchDIContainer: RecipeSearchCoordinatorDependencies {
    func makeRecipeSearchCoordinator(navigationController: UINavigationController?) -> RecipeSearchCoordinator {
        return DefaultRecipeSearchCoordinator(navigationController: navigationController)
    }
    
    func makeRecipeSearchViewController() -> UIViewController {
        return RecipeSearchViewController()
    }
    
    func makeRecipeSearchResultsViewController(with query: String) -> UIViewController {
        let viewModel = Container.shared.resolve(DefaultRecipeSearchResultsViewModel.self)
        viewModel.searchQuery.onNext(query)
        return RecipeSearchResultsViewController(viewModel: viewModel)
    }
    
    func makeRecipeSearchResultDetailViewController(with id: String) -> UIViewController {
        let viewModel = Container.shared.resolve(DefaultRecipeSearchResultDetailViewModel.self)
        viewModel.recipeName.onNext(id)
        return RecipeSearchResultDetailViewController(viewModel: viewModel)
    }
}
