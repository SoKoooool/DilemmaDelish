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
        setupConfiguarance()
        configuration = config
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.config = .plain()
        setupConfiguarance()
        config.title = "샤토브리앙"
        configuration = config
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureRoundedImage()
        configureTitle()
    }
    
    // MARK: - Configurings
    
    private func setupConfiguarance() {
        config.image = UIImage(systemName: "fork.knife.circle")
        config.imagePadding = 4
        config.baseForegroundColor = .darkText
        config.background.backgroundColor = .systemPink.withAlphaComponent(0.2)
        config.background.strokeColor = .systemPink
        config.background.strokeWidth = 2
        config.cornerStyle = .capsule
        config.preferredSymbolConfigurationForImage = .init(scale: .large)
    }
    
    private func configureRoundedImage() {
        guard let imageView = imageView else { return }
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func configureTitle() {
        guard let titleLabel = titleLabel else { return }
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.numberOfLines = 1
    }
}
