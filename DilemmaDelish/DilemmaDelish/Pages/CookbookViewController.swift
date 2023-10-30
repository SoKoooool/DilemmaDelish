//
//  CookbookViewController.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/21.
//

import UIKit

final class CookbookViewController: UIViewController {
    
    // MARK: - Dependecies
    
    private let viewModel: CookbookViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: CookbookViewModelProtocol = CookbookViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CookbookViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
