//
//  IngredientsViewTitleLabel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/25.
//

import UIKit

final class IngredientsViewTitleLabel: UILabel {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
    
    // MARK: - Configure View
    
    private func setupAppearance() {
        text = "Ingredients"
        font = .systemFont(ofSize: 24, weight: .bold)
    }
}
