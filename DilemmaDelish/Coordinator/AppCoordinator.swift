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
    
    private let appDIContainer: Container
    
    init(navigationController: UINavigationController?, appDIContainer: Container) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
    }
}

extension AppCoordinator {
    func showRecipeSearch() {
        Container.shared.register(RecipeSearchDIContainer())
        Container.shared.register(DefaultRecipeSearchCoordinator(navigationController: navigationController))
        Container.shared.register(DefaultRecipeSearchRepository())
        Container.shared.register(DefaultRecipeSearchUsecase())
        Container.shared.register(DefaultRecipeSearchViewModel())
        Container.shared.register(DefaultRecipeSearchResultsViewModel())
        Container.shared.register(DefaultRecipeSearchResultDetailViewModel())
        
        let coordinator = Container.shared.resolve(DefaultRecipeSearchCoordinator.self)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
