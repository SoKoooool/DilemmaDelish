//
//  AddIngredientButton.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/25.
//

import UIKit

final class AddIngredientButton: UIButton {
    
    // MARK: - Properties
    
    private var config: UIButton.Configuration!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config = .plain()
        setupConfiguarance()
        configuration = config
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config = .plain()
        setupConfiguarance()
        configuration = config
    }
    
    // MARK: - Configure View
    
    private func setupConfiguarance() {
        config.image = UIImage(systemName: "plus.circle")
        config.baseForegroundColor = .darkText
        config.background.backgroundColor = .white
        config.buttonSize = .large
    }
}

