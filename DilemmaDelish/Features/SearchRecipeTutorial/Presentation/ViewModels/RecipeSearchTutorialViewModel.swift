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
    var recipeTypes: Observable<[ViewRecipeType]> { get }
}

protocol RecipeMainIngredientPickerViewModel {
    var mainIngredientSelected: AnyObserver<ViewRecipeIngredient> { get }
    var mainIngredients: Observable<[ViewRecipeIngredient]> { get }
}

protocol RecipeSubIngerdientPickerViewModel {
    var subIngredientSelected: AnyObserver<ViewRecipeIngredient> { get }
    var subIngredients: Observable<[ViewRecipeIngredient]> { get }
}

protocol RecipeSearchTutorialViewModel: RecipeSearchTutorialViewModelType {
    var fetchRecipeDetail: AnyObserver<Void> { get }
}

typealias RecipeSearchTutorialViewModelType = RecipeTypePickerViewModel & RecipeMainIngredientPickerViewModel & RecipeSubIngerdientPickerViewModel

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let typeSelected: AnyObserver<ViewRecipeType>
    let mainIngredientSelected: AnyObserver<ViewRecipeIngredient>
    let subIngredientSelected: AnyObserver<ViewRecipeIngredient>
    
    let recipeTypes: Observable<[ViewRecipeType]>
    let mainIngredients: Observable<[ViewRecipeIngredient]>
    let subIngredients: Observable<[ViewRecipeIngredient]>
    
    private let disposeBag = DisposeBag()
    
    init(domain: RecipeSearchable) {
        let recipeDetailFetching = PublishSubject<Void>()
        let typeSelecting = PublishSubject<ViewRecipeType>()
        let mainIngredientSelecting = PublishSubject<ViewRecipeIngredient>()
        let subIngredientSelecting = PublishSubject<ViewRecipeIngredient>()
        
        let fetchedRecipeTypes = PublishSubject<[ViewRecipeType]>()
        let fetchedMainIngredients = PublishSubject<[ViewRecipeIngredient]>()
        let fetchedSubIngredients = PublishSubject<[ViewRecipeIngredient]>()
        
        fetchRecipeDetail = recipeDetailFetching.asObserver()
        recipeDetailFetching
            .flatMap { domain.fetchRecipeDetail() }
            .map { ViewRecipeDetail($0) }
            .subscribe(onNext: {
                fetchedRecipeTypes.onNext($0.types)
                fetchedMainIngredients.onNext($0.mainIngredients)
                fetchedSubIngredients.onNext($0.subIngredients)
            })
            .disposed(by: disposeBag)
        
        typeSelected = typeSelecting.asObserver()
        mainIngredientSelected = mainIngredientSelecting.asObserver()
        subIngredientSelected = subIngredientSelecting.asObserver()
        
        recipeTypes = fetchedRecipeTypes
        mainIngredients = fetchedMainIngredients
        subIngredients = fetchedSubIngredients
    }
}
