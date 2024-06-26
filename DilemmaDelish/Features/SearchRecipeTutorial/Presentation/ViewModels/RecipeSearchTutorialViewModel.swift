//
//  RecipeSearchTutorialViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeTypePickerViewModel {
    var typeSelected: AnyObserver<ViewRecipeType> { get }
}

protocol RecipeMainIngredientPickerViewModel {
    var mainIngredientSelected: AnyObserver<ViewRecipeIngredient> { get }
}

protocol RecipeSubIngerdientPickerViewModel {
    var subIngredientSelected: AnyObserver<ViewRecipeIngredient> { get }
}

protocol RecipeSearchTutorialViewModel {
    var fetchRecipeDetail: AnyObserver<Void> { get }
    var recipeDetail: Observable<ViewRecipeDetail> { get }
}
