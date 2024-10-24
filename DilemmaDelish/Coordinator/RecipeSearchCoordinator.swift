//
//  RecipeSearchCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

protocol RecipeSearchCoordinator: Coordinator {
    var query: String? { get set }
    func showRecipeSearch()
    func showRecipeSearchResults(with query: String)
    func showRecipeSearchResultDetail(with id: String)
}

protocol RecipeSearchCoordinatorDependencies {
    func makeRecipeSearchViewController() -> UIViewController
    func makeRecipeSearchResultsViewController(with query: String) -> UIViewController
    func makeRecipeSearchResultDetailViewController(with id: String) -> UIViewController
}

public final class DefaultRecipeSearchCoordinator: RecipeSearchCoordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    
    var query: String?
    
    private let dependencies: RecipeSearchCoordinatorDependencies
    
    init(navigationController: UINavigationController?, 
         dependencies: RecipeSearchCoordinatorDependencies = Container.shared.resolve(RecipeSearchDIContainer.self)) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        query != nil ? showRecipeSearchResults(with: query!) : showRecipeSearch()
    }
}

extension DefaultRecipeSearchCoordinator {
    func showRecipeSearch() {
        let viewController = dependencies.makeRecipeSearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipeSearchResults(with query: String) {
        let viewController = dependencies.makeRecipeSearchResultsViewController(with: query)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRecipeSearchResultDetail(with id: String) {
        let viewController = dependencies.makeRecipeSearchResultDetailViewController(with: id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
