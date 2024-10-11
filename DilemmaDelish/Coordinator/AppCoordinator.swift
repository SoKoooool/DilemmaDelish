//
//  AppCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/10/24.
//

import Foundation
import UIKit

public final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController?, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
    }
}

extension AppCoordinator {
    func showRecipeSearchTutorial() {
        let container = appDIContainer.makeRecipeSearchTutorialDIContainer()
        let coordinator = container.makeRecipeSearchTutorialCoordinator()
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
