//
//  RecipeSearchResultsViewController.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

final class RecipeSearchResultsViewController: UIViewController {
    
    private let viewModel: RecipeSearchResultsViewModel!
    
    init(viewModel: RecipeSearchResultsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
