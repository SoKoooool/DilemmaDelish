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
    func makeRecipeSearchViewController() -> UIViewController
    func makeRecipeSearchResultsViewController(with searchable: RecipeSearchable) -> UIViewController
    func makeRecipeSearchResultDetailViewController(with id: String) -> UIViewController
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
        let viewController = dependencies.makeRecipeSearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipeSearchResults(from searchable: RecipeSearchable) {
        let viewController = dependencies.makeRecipeSearchResultsViewController(with: searchable)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipeSearchResultDetail(with id: String) {
        let viewController = dependencies.makeRecipeSearchResultDetailViewController(with: id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
