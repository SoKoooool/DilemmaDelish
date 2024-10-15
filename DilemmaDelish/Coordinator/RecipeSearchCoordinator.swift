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
}

public final class DefaultRecipeSearchCoordinator: RecipeSearchCoordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    
    private let dependencies: RecipeSearchCoordinatorDependencies
    
    init(navigationController: UINavigationController?, dependencies: RecipeSearchCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showRecipeSearch()
    }
}

extension DefaultRecipeSearchCoordinator {
    func showRecipeSearch() {
        
    }
    
    func showRecipeSearchResults(from searchable: RecipeSearchable) {
        
    }
    
    func showRecipeSearchResultDetail(with id: String) {
        
    }
}
