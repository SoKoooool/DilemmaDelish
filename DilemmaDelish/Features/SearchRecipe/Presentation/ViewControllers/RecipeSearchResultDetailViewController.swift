//
//  RecipeSearchResultDetailViewController.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

final class RecipeSearchResultDetailViewController: UIViewController {
    
    private let viewModel: RecipeSearchResultDetailViewModel!
    
    init(viewModel: RecipeSearchResultDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
