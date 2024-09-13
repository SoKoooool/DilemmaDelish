//
//  RecipeSearchTutorialViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeCategoryPickerViewModel {
    var selectCategory: AnyObserver<ViewRecipeDetail.Category> { get }
    var moveIngredientPickerPage: AnyObserver<Void> { get }
    var ingredientPickerPage: Observable<Void> { get }
}

protocol RecipeIngredientPickerViewModel {
    var selectIngredient: AnyObserver<ViewRecipeDetail.Ingredient> { get }
    var moveSeasoningPickerPage: AnyObserver<Void> { get }
    var seasoningPickerPage: Observable<Void> { get }
}

protocol RecipeSubIngerdientPickerViewModel {
    var selectSeasoning: AnyObserver<ViewRecipeDetail.Seasoning> { get }
    var searchRecipe: AnyObserver<Void> { get }
    var searchRecipsResultPage: Observable<[Recipe]> { get }
}

protocol RecipeSearchTutorialViewModel: RecipeSearchTutorialViewModelType {
    var fetchRecipeDetail: AnyObserver<Void> { get }
    var recipeDetail: Observable<ViewRecipeDetail> { get }
}

typealias RecipeSearchTutorialViewModelType = RecipeCategoryPickerViewModel & RecipeIngredientPickerViewModel & RecipeSubIngerdientPickerViewModel

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let selectCategory: AnyObserver<ViewRecipeDetail.Category>
    let selectIngredient: AnyObserver<ViewRecipeDetail.Ingredient>
    let selectSeasoning: AnyObserver<ViewRecipeDetail.Seasoning>
    let moveIngredientPickerPage: AnyObserver<Void>
    let moveSeasoningPickerPage: AnyObserver<Void>
    let searchRecipe: AnyObserver<Void>
    
    let recipeDetail: Observable<ViewRecipeDetail>
    let ingredientPickerPage: Observable<Void>
    let seasoningPickerPage: Observable<Void>
    let searchRecipsResultPage: Observable<[Recipe]>
    
    private let disposeBag = DisposeBag()
    
    init(domain: RecipeSearchable) {
        let fetching = PublishSubject<Void>()
        let filtering = PublishSubject<ViewRecipeDetail.Category>()
        let ingredientCollecting = PublishSubject<ViewRecipeDetail.Ingredient>()
        let seasoningCollecting = PublishSubject<ViewRecipeDetail.Seasoning>()
        let ingredientPickerPageMoving = PublishSubject<Void>()
        let seasoningPickerPageMoving = PublishSubject<Void>()
        let searching = PublishSubject<Void>()
        
        let viewRecipeDetail = PublishSubject<ViewRecipeDetail>()
        let recipeQuery = PublishSubject<RecipeQuery>()
        let recipes = PublishSubject<[Recipe]>()
        
        fetchRecipeDetail = fetching.asObserver()
        fetching
            .flatMap { domain.fetchRecipeDetail() }
            .map { ViewRecipeDetail($0) }
            .subscribe(onNext: viewRecipeDetail.onNext)
            .disposed(by: disposeBag)
        
        recipeDetail = viewRecipeDetail.asObserver()
        
        selectCategory = filtering.asObserver()
        selectIngredient = ingredientCollecting.asObserver()
        selectSeasoning = seasoningCollecting.asObserver()
    
        moveIngredientPickerPage = ingredientPickerPageMoving.asObserver()
        moveSeasoningPickerPage = seasoningPickerPageMoving.asObserver()
        searchRecipe = searching.asObserver()
        searching
            .withLatestFrom(recipeQuery)
            .flatMap { domain.searchRecipe(with: $0) }
            .subscribe(onNext: recipes.onNext)
            .disposed(by: disposeBag)
        
        ingredientPickerPage = ingredientPickerPageMoving
        seasoningPickerPage = seasoningPickerPageMoving
        searchRecipsResultPage = recipes
    }
}
