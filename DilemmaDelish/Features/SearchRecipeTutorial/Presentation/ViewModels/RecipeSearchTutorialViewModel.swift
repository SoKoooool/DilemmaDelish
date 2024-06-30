//
//  RecipeSearchTutorialViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeTypePickerViewModel {
    var selectRecipeType: AnyObserver<ViewRecipeType> { get }
    var moveMainPickerPage: AnyObserver<Void> { get }
    var recipeTypes: Observable<[ViewRecipeType]> { get }
    var mainPickerPage: Observable<Void> { get }
}

protocol RecipeMainIngredientPickerViewModel {
    var selectMainIngredient: AnyObserver<ViewRecipeIngredient> { get }
    var moveSubPickerPage: AnyObserver<Void> { get }
    var mainIngredients: Observable<[ViewRecipeIngredient]> { get }
    var subPickerPage: Observable<Void> { get }
}

protocol RecipeSubIngerdientPickerViewModel {
    var selectSubIngredient: AnyObserver<ViewRecipeIngredient> { get }
    var moveSearchResultPage: AnyObserver<Void> { get }
    var subIngredients: Observable<[ViewRecipeIngredient]> { get }
    var searchResultPage: Observable<[Recipe]> { get }
}

protocol RecipeSearchTutorialViewModel: RecipeSearchTutorialViewModelType {
    var fetchRecipeDetail: AnyObserver<Void> { get }
}

typealias RecipeSearchTutorialViewModelType = RecipeTypePickerViewModel & RecipeMainIngredientPickerViewModel & RecipeSubIngerdientPickerViewModel

final class DefaultRecipeSearchTutorialViewModel: RecipeSearchTutorialViewModel {
    
    let fetchRecipeDetail: AnyObserver<Void>
    let selectRecipeType: AnyObserver<ViewRecipeType>
    let selectMainIngredient: AnyObserver<ViewRecipeIngredient>
    let selectSubIngredient: AnyObserver<ViewRecipeIngredient>
    let moveMainPickerPage: AnyObserver<Void>
    let moveSubPickerPage: AnyObserver<Void>
    let moveSearchResultPage: AnyObserver<Void>
    
    let recipeTypes: Observable<[ViewRecipeType]>
    let mainIngredients: Observable<[ViewRecipeIngredient]>
    let subIngredients: Observable<[ViewRecipeIngredient]>
    let mainPickerPage: Observable<Void>
    let subPickerPage: Observable<Void>
    let searchResultPage: Observable<[Recipe]>
    
    private let disposeBag = DisposeBag()
    
    init(domain: RecipeSearchable) {
        let recipeDetailFetching = PublishSubject<Void>()
        let recipeTypeSelecting = PublishSubject<ViewRecipeType>()
        let mainIngredientSelecting = PublishSubject<ViewRecipeIngredient>()
        let subIngredientSelecting = PublishSubject<ViewRecipeIngredient>()
        let mainPickerPageMoving = PublishSubject<Void>()
        let subPickerPageMoving = PublishSubject<Void>()
        let searchResultPageMoving = PublishSubject<Void>()
        
        let fetchedRecipeTypes = PublishSubject<[ViewRecipeType]>()
        let fetchedMainIngredients = PublishSubject<[ViewRecipeIngredient]>()
        let fetchedSubIngredients = PublishSubject<[ViewRecipeIngredient]>()
        let recipeQuery = PublishSubject<RecipeQuery>()
        let searchedRecipe = PublishSubject<[Recipe]>()
        
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
        
        selectRecipeType = recipeTypeSelecting.asObserver()
        let selectedRecipeType = recipeTypeSelecting
            .withLatestFrom(fetchedRecipeTypes) { selected, fetched in
                return fetched
                    .map { $0.selected(state: false) }
                    .map { $0.name == selected.name ? selected.name : $0.name }
            }
            .flatMap { Observable.from($0) }
        
        selectMainIngredient = mainIngredientSelecting.asObserver()
        let selectedMainIngredient = mainIngredientSelecting
            .scan(into: [""]) { seed, selected in
                seed.contains(selected.name) ?
                seed = seed.filter { $0 != selected.name } : seed.append(selected.name)
            }
        
        selectSubIngredient = subIngredientSelecting.asObserver()
        let selectedSubIngredient = subIngredientSelecting
            .scan(into: [""]) { seed, selected in
                seed.contains(selected.name) ?
                seed = seed.filter { $0 != selected.name } : seed.append(selected.name)
            }
        
        Observable.combineLatest(selectedRecipeType,
                                 selectedMainIngredient,
                                 selectedSubIngredient) {
            return RecipeQuery(recipeType: $0,
                               mainIngredients: $1,
                               additionalIngredients: $2)
        }
                                 .subscribe(onNext: recipeQuery.onNext)
                                 .disposed(by: disposeBag)
        
        moveMainPickerPage = mainPickerPageMoving.asObserver()
        moveSubPickerPage = subPickerPageMoving.asObserver()
        moveSearchResultPage = searchResultPageMoving.asObserver()
        searchResultPageMoving
            .withLatestFrom(recipeQuery)
            .flatMap { domain.searchRecipe(with: $0) }
            .subscribe(onNext: searchedRecipe.onNext)
            .disposed(by: disposeBag)
        
        recipeTypes = fetchedRecipeTypes
        mainIngredients = fetchedMainIngredients
        subIngredients = fetchedSubIngredients
        mainPickerPage = mainPickerPageMoving
        subPickerPage = subPickerPageMoving
        searchResultPage = searchedRecipe
    }
}
