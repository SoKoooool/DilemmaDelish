//
//  RecipeSearchTutorialViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeCategoryPickerViewModel {
    var selectCategory: AnyObserver<ViewRecipeCategory> { get }
    var moveIngredientPickerPage: AnyObserver<Void> { get }
    var categories: Observable<[ViewRecipeCategory]> { get }
    var ingredientPickerPage: Observable<Void> { get }
}

protocol RecipeIngredientPickerViewModel {
    var selectIngredient: AnyObserver<ViewRecipeIngredient> { get }
    var moveSeasoningPickerPage: AnyObserver<Void> { get }
    var ingredients: Observable<[ViewRecipeIngredient]> { get }
    var seasoningPickerPage: Observable<Void> { get }
}

protocol RecipeSubIngerdientPickerViewModel {
    var selectSeasoning: AnyObserver<ViewRecipeSeasoning> { get }
    var searchRecipe: AnyObserver<Void> { get }
    var seasonings: Observable<[ViewRecipeSeasoning]> { get }
    var searchRecipsResultPage: Observable<[Recipe]> { get }
}

protocol RecipeSearchTutorialViewModel: RecipeSearchTutorialViewModelType {
    var fetchRecipeDetail: AnyObserver<Void> { get }
}

typealias RecipeSearchTutorialViewModelType = RecipeCategoryPickerViewModel & RecipeIngredientPickerViewModel & RecipeSubIngerdientPickerViewModel

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let selectCategory: AnyObserver<ViewRecipeCategory>
    let selectIngredient: AnyObserver<ViewRecipeIngredient>
    let selectSeasoning: AnyObserver<ViewRecipeSeasoning>
    let moveIngredientPickerPage: AnyObserver<Void>
    let moveSeasoningPickerPage: AnyObserver<Void>
    let searchRecipe: AnyObserver<Void>
    
    let categories: Observable<[ViewRecipeCategory]>
    let ingredients: Observable<[ViewRecipeIngredient]>
    let seasonings: Observable<[ViewRecipeSeasoning]>
    let ingredientPickerPage: Observable<Void>
    let seasoningPickerPage: Observable<Void>
    let searchRecipsResultPage: Observable<[Recipe]>
    
    private let disposeBag = DisposeBag()
    
    init(domain: RecipeSearchable) {
        let fetching = PublishSubject<Void>()
        let filtering = PublishSubject<ViewRecipeCategory>()
        let ingredientCollecting = PublishSubject<ViewRecipeIngredient>()
        let seasoningCollecting = PublishSubject<ViewRecipeSeasoning>()
        let ingredientPickerPageMoving = PublishSubject<Void>()
        let seasoningPickerPageMoving = PublishSubject<Void>()
        let searching = PublishSubject<Void>()
        
        let viewCategories = PublishSubject<[ViewRecipeCategory]>()
        let viewIngredients = PublishSubject<[ViewRecipeIngredient]>()
        let viewSeasonings = PublishSubject<[ViewRecipeSeasoning]>()
        let recipeQuery = PublishSubject<RecipeQuery>()
        let recipes = PublishSubject<[Recipe]>()
        
        fetchRecipeDetail = fetching.asObserver()
        fetching
            .flatMap { domain.fetchRecipeDetail() }
            .subscribe(onNext: {
                viewCategories.onNext($0.categories)
                viewIngredients.onNext($0.ingredients)
                viewSeasonings.onNext($0.seasonings)
            })
            .disposed(by: disposeBag)
        
        selectCategory = filtering.asObserver()
        let categoryName = filtering
            .withLatestFrom(viewCategories) { category, categories in
                return categories
                    .map { $0.selected(state: false) }
                    .map { $0.name == category.name ? category.name : $0.name }
            }
            .flatMap { Observable.from($0) }
        
        selectIngredient = ingredientCollecting.asObserver()
        let ingredientNames = ingredientCollecting
            .scan(into: [""]) { seed, selected in
                seed.contains(selected.name) ?
                seed = seed.filter { $0 != selected.name } : seed.append(selected.name)
            }
        
        selectSeasoning = seasoningCollecting.asObserver()
        let seasoningNames = seasoningCollecting
            .scan(into: [""]) { seed, selected in
                seed.contains(selected.name) ?
                seed = seed.filter { $0 != selected.name } : seed.append(selected.name)
            }
        
        Observable.combineLatest(categoryName,
                                 ingredientNames,
                                 seasoningNames) {
            return RecipeQuery(category: $0,
                               ingredients: $1,
                               seasonings: $2)
        }
                                 .subscribe(onNext: recipeQuery.onNext)
                                 .disposed(by: disposeBag)
        
        moveIngredientPickerPage = ingredientPickerPageMoving.asObserver()
        moveSeasoningPickerPage = seasoningPickerPageMoving.asObserver()
        searchRecipe = searching.asObserver()
        searching
            .withLatestFrom(recipeQuery)
            .flatMap { domain.searchRecipe(with: $0) }
            .subscribe(onNext: recipes.onNext)
            .disposed(by: disposeBag)
        
        categories = viewCategories
        ingredients = viewIngredients
        seasonings = viewSeasonings
        ingredientPickerPage = ingredientPickerPageMoving
        seasoningPickerPage = seasoningPickerPageMoving
        searchRecipsResultPage = recipes
    }
}
