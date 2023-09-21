//
//  IngredientButton.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/21.
//

import UIKit

final class IngredientButton: UIButton {
    
    // MARK: - Properties
    
    private var config: UIButton.Configuration!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config = .plain()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
