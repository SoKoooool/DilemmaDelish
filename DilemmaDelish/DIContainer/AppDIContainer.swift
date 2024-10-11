//
//  AppDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/10/24.
//

import Foundation
import UIKit

public final class AppDIContainer {
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeRecipeSearchTutorialDIContainer() -> RecipeSearchTutorialDIContainer {
        return RecipeSearchTutorialDIContainer(navigationController: navigationController)
    }
}
