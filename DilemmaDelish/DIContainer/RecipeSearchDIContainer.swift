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
