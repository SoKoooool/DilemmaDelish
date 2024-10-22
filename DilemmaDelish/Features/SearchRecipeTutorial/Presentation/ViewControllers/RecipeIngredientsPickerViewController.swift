//
//  RecipeIngredientsPickerViewController.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

final class RecipeIngredientsPickerViewController: UIViewController {
    
    private let viewModel: RecipeSearchTutorialViewModel!
    
    init(viewModel: RecipeSearchTutorialViewModel = Container.shared.resolve(DefaultRecipeSearchTutorialViewModel.self)) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
