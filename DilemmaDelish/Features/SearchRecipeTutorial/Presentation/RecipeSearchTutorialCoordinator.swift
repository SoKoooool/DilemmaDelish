//
//  RecipeSearchTutorialCoordinator.swift
//  DilemmaDelish
//
//  Created by TORI on 10/8/24.
//

import Foundation
import UIKit

protocol RecipeSearchTutorialCoordinatorDependencies {
    func makeCategoriesPickerViewController() -> UIViewController
    func makeIngredientsPickerViewController() -> UIViewController
    func makeSeasoningsPickerViewController() -> UIViewController
}
