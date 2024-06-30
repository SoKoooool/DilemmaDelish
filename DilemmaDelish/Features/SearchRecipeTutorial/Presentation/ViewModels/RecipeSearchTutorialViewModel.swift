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
    var moveSearchRecipeResultPage: AnyObserver<Void> { get }
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
    let moveSearchRecipeResultPage: AnyObserver<Void>
    
    let categories: Observable<[ViewRecipeCategory]>
    let ingredients: Observable<[ViewRecipeIngredient]>
    let seasonings: Observable<[ViewRecipeSeasoning]>
    let ingredientPickerPage: Observable<Void>
    let seasoningPickerPage: Observable<Void>
    let searchRecipsResultPage: Observable<[Recipe]>
    
    private let disposeBag = DisposeBag()
    
    init(domain: RecipeSearchable) {
        let recipeDetailFetching = PublishSubject<Void>()
        let categorySelecting = PublishSubject<ViewRecipeCategory>()
        let ingredientSelecting = PublishSubject<ViewRecipeIngredient>()
        let seasoningSelecting = PublishSubject<ViewRecipeSeasoning>()
        let ingredientPickerPageMoving = PublishSubject<Void>()
        let seasoningPickerPageMoving = PublishSubject<Void>()
        let searchRecipeResultPageMoving = PublishSubject<Void>()
        
        let viewCategories = PublishSubject<[ViewRecipeCategory]>()
        let viewIngredients = PublishSubject<[ViewRecipeIngredient]>()
        let viewSeasonings = PublishSubject<[ViewRecipeSeasoning]>()
        let recipeQuery = PublishSubject<RecipeQuery>()
        let recipes = PublishSubject<[Recipe]>()
        
        fetchRecipeDetail = recipeDetailFetching.asObserver()
        recipeDetailFetching
            .flatMap { domain.fetchRecipeDetail() }
            .map { ViewRecipeDetail($0) }
            .subscribe(onNext: {
                viewCategories.onNext($0.categories)
                viewIngredients.onNext($0.ingredients)
                viewSeasonings.onNext($0.seasonings)
            })
            .disposed(by: disposeBag)
        
        selectCategory = categorySelecting.asObserver()
        let selectedRecipeType = categorySelecting
            .withLatestFrom(viewCategories) { selected, fetched in
                return fetched
                    .map { $0.selected(state: false) }
                    .map { $0.name == selected.name ? selected.name : $0.name }
            }
            .flatMap { Observable.from($0) }
        
        selectIngredient = ingredientSelecting.asObserver()
        let selectedMainIngredient = ingredientSelecting
            .scan(into: [""]) { seed, selected in
                seed.contains(selected.name) ?
                seed = seed.filter { $0 != selected.name } : seed.append(selected.name)
            }
        
        selectSeasoning = seasoningSelecting.asObserver()
        let selectedSubIngredient = seasoningSelecting
            .scan(into: [""]) { seed, selected in
                seed.contains(selected.name) ?
                seed = seed.filter { $0 != selected.name } : seed.append(selected.name)
            }
        
        Observable.combineLatest(selectedRecipeType,
                                 selectedMainIngredient,
                                 selectedSubIngredient) {
            return RecipeQuery(category: $0,
                               ingredients: $1,
                               seasonings: $2)
        }
                                 .subscribe(onNext: recipeQuery.onNext)
                                 .disposed(by: disposeBag)
        
        moveIngredientPickerPage = ingredientPickerPageMoving.asObserver()
        moveSeasoningPickerPage = seasoningPickerPageMoving.asObserver()
        moveSearchRecipeResultPage = searchRecipeResultPageMoving.asObserver()
        searchRecipeResultPageMoving
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
