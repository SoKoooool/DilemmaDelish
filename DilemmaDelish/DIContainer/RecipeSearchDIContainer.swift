//
//  RecipeSearchDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/14/24.
//

import Foundation
import UIKit

public final class RecipeSearchDIContainer: RecipeSearchCoordinatorDependencies {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    
}
