//
//  Coordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/10/24.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
