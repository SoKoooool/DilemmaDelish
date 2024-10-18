//
//  RecipeSearchViewController.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

final class RecipeSearchViewController: UIViewController {
    
    private let viewModel: RecipeSearchViewModel!
    
    init(viewModel: RecipeSearchViewModel = Container.shared.resolve(DefaultRecipeSearchViewModel.self)) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
