//
//  RecipeSearchTutorialViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeCategoryPickerViewModel {
    var pickCategories: AnyObserver<[ViewRecipeDetail.Category]> { get }
    var recipeCategories: Observable<[ViewRecipeDetail.Category]> { get }
    var ingredientPickerPage: Observable<Void> { get }
}

protocol RecipeIngredientPickerViewModel {
    var pickIngredients: AnyObserver<[ViewRecipeDetail.Ingredient]> { get }
    var recipeIngredients: Observable<[ViewRecipeDetail.Ingredient]> { get }
    var seasoningPickerPage: Observable<Void> { get }
}

protocol RecipeSubIngerdientPickerViewModel {
    var pickSeasonings: AnyObserver<[ViewRecipeDetail.Seasoning]> { get }
    var recipeSeasonings: Observable<[ViewRecipeDetail.Seasoning]> { get }
}

protocol RecipeSearchTutorialViewModel: RecipeSearchTutorialViewModelType {
    var fetchRecipeDetail: AnyObserver<Void> { get }
}

typealias RecipeSearchTutorialViewModelType = RecipeCategoryPickerViewModel & RecipeIngredientPickerViewModel & RecipeSubIngerdientPickerViewModel

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let pickCategories: AnyObserver<[ViewRecipeDetail.Category]>
    let pickIngredients: AnyObserver<[ViewRecipeDetail.Ingredient]>
    let pickSeasonings: AnyObserver<[ViewRecipeDetail.Seasoning]>
    
    let recipeCategories: Observable<[ViewRecipeDetail.Category]>
    let recipeIngredients: Observable<[ViewRecipeDetail.Ingredient]>
    let recipeSeasonings: Observable<[ViewRecipeDetail.Seasoning]>
    let ingredientPickerPage: Observable<Void>
    let seasoningPickerPage: Observable<Void>
    
    private let disposeBag = DisposeBag()
    
    init(recipeSearchTutorialUsecase: RecipeSearchTutorialUsecase, coordinator: RecipeSearchTutorialCoordinator) {
        let fetching = PublishSubject<Void>()
        let pickedCategories = PublishSubject<[ViewRecipeDetail.Category]>()
        let pickedIngredients = PublishSubject<[ViewRecipeDetail.Ingredient]>()
        let pickedSeasonings = PublishSubject<[ViewRecipeDetail.Seasoning]>()
        
        let recipeDetail = PublishSubject<RecipeDetail>()
        let categories = PublishSubject<[ViewRecipeDetail.Category]>()
        let ingredients = PublishSubject<[ViewRecipeDetail.Ingredient]>()
        let seasonings = PublishSubject<[ViewRecipeDetail.Seasoning]>()
        
        fetchRecipeDetail = fetching.asObserver()
        fetching
            .flatMap { recipeSearchTutorialUsecase.execute() }
            .subscribe(onNext: recipeDetail.onNext)
            .disposed(by: disposeBag)
        
        recipeCategories = categories.asObserver()
        categories.withLatestFrom(recipeDetail)
            .map { $0.categories.map { ViewRecipeDetail.Category($0) } }
            .subscribe(onNext: categories.onNext(_:))
            .disposed(by: disposeBag)
        
        recipeIngredients = ingredients.asObserver()
        ingredients.withLatestFrom(recipeDetail)
            .map { $0.ingredients.map { ViewRecipeDetail.Ingredient($0) } }
            .subscribe(onNext: ingredients.onNext(_:))
            .disposed(by: disposeBag)
        
        recipeSeasonings = seasonings.asObserver()
        seasonings.withLatestFrom(recipeDetail)
            .map { $0.seasonings.map { ViewRecipeDetail.Seasoning($0) } }
            .subscribe(onNext: seasonings.onNext(_:))
            .disposed(by: disposeBag)
        
        pickCategories = pickedCategories.asObserver()
        pickedCategories
            .flatMap { Observable.from($0) }
            .withLatestFrom(categories) { selected, categories in
                categories.map { $0.name == selected.name ? selected : $0 }
            }
            .scan([ViewRecipeDetail.Category]()) { $0 + $1 }
            .subscribe(onNext: categories.onNext(_:))
            .disposed(by: disposeBag)
        
        pickIngredients = pickedIngredients.asObserver()
        pickedIngredients
            .flatMap { Observable.from($0) }
            .withLatestFrom(ingredients) { selected, ingredients in
                ingredients.map { $0.name == selected.name ? selected : $0 }
            }
            .scan([ViewRecipeDetail.Ingredient]()) { $0 + $1 }
            .subscribe(onNext: ingredients.onNext(_:))
            .disposed(by: disposeBag)
            
        pickSeasonings = pickedSeasonings.asObserver()
        pickedSeasonings
            .flatMap { Observable.from($0) }
            .withLatestFrom(seasonings) { selected, seasonings in
                seasonings.map { $0.name == selected.name ? selected : $0 }
            }
            .scan([ViewRecipeDetail.Seasoning]()) { $0 + $1 }
            .subscribe(onNext: seasonings.onNext(_:))
            .disposed(by: disposeBag)
        
        Observable.combineLatest(pickedCategories, pickedIngredients, pickedSeasonings) {
            return ViewRecipeDetail(categories: $0.filter { $0.isSelected },
                                    ingredients: $1.filter { $0.isSelected },
                                    seasonings: $2.filter { $0.isSelected })
        }
        .map { $0.toQuery() }
        .subscribe { coordinator.didFinishCoordinate(with: $0) }
        .disposed(by: disposeBag)
        
        ingredientPickerPage = pickedCategories.map { _ in }
        seasoningPickerPage = pickedIngredients.map { _ in }
    }
}
