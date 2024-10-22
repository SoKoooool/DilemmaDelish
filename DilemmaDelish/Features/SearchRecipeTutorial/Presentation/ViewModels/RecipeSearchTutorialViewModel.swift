//
//  RecipeSearchTutorialViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeSearchTutorialViewModel {
    var fetchRecipeDetail: AnyObserver<Void> { get }
    var pickCategory: AnyObserver<ViewRecipeDetail.Category> { get }
    var pickIngredient: AnyObserver<ViewRecipeDetail.Ingredient> { get }
    var pickSeasoning: AnyObserver<ViewRecipeDetail.Seasoning> { get }
    var showIngredientsPicker: AnyObserver<Void> { get }
    var showSeasoningsPicker: AnyObserver<Void> { get }
    var showSearchResult: AnyObserver<Void> { get }
    
    var recipeCategories: Observable<[ViewRecipeDetail.Category]> { get }
    var recipeIngredients: Observable<[ViewRecipeDetail.Ingredient]> { get }
    var recipeSeasonings: Observable<[ViewRecipeDetail.Seasoning]> { get }
}

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let pickCategory: AnyObserver<ViewRecipeDetail.Category>
    let pickIngredient: AnyObserver<ViewRecipeDetail.Ingredient>
    let pickSeasoning: AnyObserver<ViewRecipeDetail.Seasoning>
    let showIngredientsPicker: AnyObserver<Void>
    let showSeasoningsPicker: AnyObserver<Void>
    let showSearchResult: AnyObserver<Void>
    
    let recipeCategories: Observable<[ViewRecipeDetail.Category]>
    let recipeIngredients: Observable<[ViewRecipeDetail.Ingredient]>
    let recipeSeasonings: Observable<[ViewRecipeDetail.Seasoning]>
    
    private let disposeBag = DisposeBag()
    
    init(recipeSearchTutorialUsecase: RecipeSearchTutorialUsecase = Container.shared.resolve(DefaultRecipeSearchTutorialUsecase.self),
         coordinator: RecipeSearchTutorialCoordinator = Container.shared.resolve(RecipeSearchTutorialCoordinator.self)) {
        let fetching = PublishSubject<Void>()
        let categoryPicking = PublishSubject<ViewRecipeDetail.Category>()
        let ingredientPicking = PublishSubject<ViewRecipeDetail.Ingredient>()
        let seasoningPicking = PublishSubject<ViewRecipeDetail.Seasoning>()
        let ingredientsPickerShowing = PublishSubject<Void>()
        let seasoningsPickerShowing = PublishSubject<Void>()
        let recipeSearchResultShowing = PublishSubject<Void>()
        
        let categories = PublishSubject<[ViewRecipeDetail.Category]>()
        let ingredients = PublishSubject<[ViewRecipeDetail.Ingredient]>()
        let seasonings = PublishSubject<[ViewRecipeDetail.Seasoning]>()
        
        fetchRecipeDetail = fetching.asObserver()
        fetching
            .flatMap { recipeSearchTutorialUsecase.execute() }
            .map { ViewRecipeDetail($0) }
            .subscribe {
                categories.onNext($0.categories)
                ingredients.onNext($0.ingredients)
                seasonings.onNext($0.seasonings)
            }
            .disposed(by: disposeBag)
        
        pickCategory = categoryPicking.asObserver()
        categoryPicking
            .withLatestFrom(categories) { selected, categories in
                return categories.map { $0.name == selected.name ? selected : $0 }
            }
            .subscribe(onNext: categories.onNext(_:))
            .disposed(by: disposeBag)
        
        pickIngredient = ingredientPicking.asObserver()
        ingredientPicking
            .withLatestFrom(ingredients) { selected, ingredients in
                return ingredients.map { $0.name == selected.name ? selected : $0 }
            }
            .subscribe(onNext: ingredients.onNext(_:))
            .disposed(by: disposeBag)
        
        pickSeasoning = seasoningPicking.asObserver()
        seasoningPicking
            .withLatestFrom(seasonings) { selected, seasonings in
                return seasonings.map { $0.name == selected.name ? selected : $0 }
            }
            .subscribe(onNext: seasonings.onNext(_:))
            .disposed(by: disposeBag)
        
        showIngredientsPicker = ingredientsPickerShowing.asObserver()
        ingredientsPickerShowing
            .subscribe { _ in coordinator.showIngredientsPicker() }
            .disposed(by: disposeBag)
        
        showSeasoningsPicker = seasoningsPickerShowing.asObserver()
        seasoningsPickerShowing
            .subscribe { _ in coordinator.showSeasoningsPicker() }
            .disposed(by: disposeBag)
        
        let updated = Observable.combineLatest(categories, ingredients, seasonings)
        showSearchResult = recipeSearchResultShowing.asObserver()
        recipeSearchResultShowing
            .withLatestFrom(updated)
            .map { ViewRecipeDetail($0) }
            .map { $0.filteredSelection() }
            .map { $0.toQuery() }
            .subscribe { coordinator.didFinishCoordinate(with: $0) }
            .disposed(by: disposeBag)
        
        recipeCategories = categories
        recipeIngredients = ingredients
        recipeSeasonings = seasonings
    }
}
