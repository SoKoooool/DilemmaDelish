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
    var showRecipeDetail: AnyObserver<String> { get }
    
    var recipeResults: Observable<[Recipe]> { get }
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
}

public final class DefaultRecipeSearchResultsViewModel: RecipeSearchResultsViewModel {
    
    private let disposeBag = DisposeBag()
    
    let searchableRecipe: AnyObserver<RecipeSearchable>
    let showRecipeDetail: AnyObserver<String>
    
    let recipeResults: Observable<[Recipe]>
    let isLoading: Observable<Bool>
    let errorMessage: Observable<String>
    
    init(recipeSearchUsecase: RecipeSearchUsecase, coordinator: RecipeSearchCoordinator) {
        let searching = PublishSubject<RecipeSearchable>()
        let detailing = PublishSubject<String>()
        
        let recipes = PublishSubject<[Recipe]>()
        let activating = PublishSubject<Bool>()
        let error = PublishSubject<Error>()
        
        searchableRecipe = searching.asObserver()
        searching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap { recipeSearchUsecase.execute(from: $0) }
            .do(onNext: { _ in activating.onNext(true) })
            .do(onError: error.onNext(_:))
            .subscribe(onNext: recipes.onNext(_:))
            .disposed(by: disposeBag)
        
        showRecipeDetail = detailing.asObserver()
        detailing
            .subscribe { coordinator.showRecipeSearchResultDetail(with: $0) }
            .disposed(by: disposeBag)
        
        recipeResults = recipes
        isLoading = activating
        errorMessage = error.map { $0.localizedDescription }
    }
}
