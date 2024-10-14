//
//  RecipeSearchResultsViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 9/30/24.
//

import Foundation
import RxSwift

protocol RecipeSearchResultsViewModel {
    var searchableRecipe: AnyObserver<RecipeSearchable> { get }
    
    var recipeResults: Observable<[Recipe]> { get }
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
    var showDetailPage: Observable<String> { get }
}

private final class DefaultRecipeSearchResultsViewModel: RecipeSearchResultsViewModel {
    
    private let disposeBag = DisposeBag()
    
    let searchableRecipe: AnyObserver<RecipeSearchable>
    let findRecipe: AnyObserver<Int>
    
    let recipeResults: Observable<[Recipe]>
    let isLoading: Observable<Bool>
    let errorMessage: Observable<String>
    let showDetailPage: Observable<String>
    
    init(recipeSearchUsecase: RecipeSearchUsecase, coordinator: RecipeSearchCoordinator) {
        let searching = PublishSubject<RecipeSearchable>()
        let finding = PublishSubject<Int>()
        
        let recipes = PublishSubject<[Recipe]>()
        let activating = PublishSubject<Bool>()
        let error = PublishSubject<Error>()
        let recipeName = PublishSubject<String>()
        
        searchableRecipe = searching.asObserver()
        searching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap { recipeSearchUsecase.execute(from: $0) }
            .do(onNext: { _ in activating.onNext(true) })
            .do(onError: error.onNext(_:))
            .subscribe(onNext: recipes.onNext(_:))
            .disposed(by: disposeBag)
        
        findRecipe = finding.asObserver()
        finding.withLatestFrom(recipes) { indexPath, recipes in
            return recipes[indexPath]
        }
        .map { $0.name }
        .subscribe(onNext: recipeName.onNext(_:))
        .disposed(by: disposeBag)
        
        recipeResults = recipes
        isLoading = activating
        errorMessage = error.map { $0.localizedDescription }
        showDetailPage = recipeName
    }
}
