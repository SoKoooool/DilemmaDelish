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

protocol RecipeSearchTutorialViewModel: RecipeSearchTutorialViewModelType {
    var fetchRecipeDetail: AnyObserver<Void> { get }
    var recipeDetail: Observable<ViewRecipeDetail> { get }
}

typealias RecipeSearchTutorialViewModelType = RecipeTypePickerViewModel & RecipeMainIngredientPickerViewModel & RecipeSubIngerdientPickerViewModel

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let typeSelected: AnyObserver<ViewRecipeType>
    let mainIngredientSelected: AnyObserver<ViewRecipeIngredient>
    let subIngredientSelected: AnyObserver<ViewRecipeIngredient>
    
    let recipeDetail: Observable<ViewRecipeDetail>
    
    init() {
        let recipeDetailFetching = PublishSubject<Void>()
        let typeSelecting = PublishSubject<ViewRecipeType>()
        let mainIngredientSelecting = PublishSubject<ViewRecipeIngredient>()
        let subIngredientSelecting = PublishSubject<ViewRecipeIngredient>()
        
        let fetchedRecipeDetail = PublishSubject<ViewRecipeDetail>()
        
        fetchRecipeDetail = recipeDetailFetching.asObserver()
        typeSelected = typeSelecting.asObserver()
        mainIngredientSelected = mainIngredientSelecting.asObserver()
        subIngredientSelected = subIngredientSelecting.asObserver()
        
        recipeDetail = fetchedRecipeDetail
    }
}
