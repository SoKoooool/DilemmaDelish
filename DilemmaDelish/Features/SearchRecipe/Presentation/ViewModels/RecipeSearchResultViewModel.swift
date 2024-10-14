//
//  RecipeSearchResultViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 9/30/24.
//

import Foundation
import RxSwift

protocol RecipeSearchResultViewModel {
    var searchQuery: AnyObserver<String> { get }
    var recipes: Observable<[Recipe]> { get }
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
    var showDetailPage: Observable<String> { get }
}

private final class DefaultRecipeSearchResultViewModel: RecipeSearchResultViewModel {
    
    private let disposeBag = DisposeBag()
    
    let searchQuery: AnyObserver<String>
    let findRecipe: AnyObserver<Int>
    
    let recipes: Observable<[Recipe]>
    let isLoading: Observable<Bool>
    let errorMessage: Observable<String>
    let showDetailPage: Observable<String>
    
    init(recipeSearchUsecase: RecipeSearchUsecase) {
        let searching = PublishSubject<String>()
        let finding = PublishSubject<Int>()
        
        let recipeList = PublishSubject<[Recipe]>()
        let activating = PublishSubject<Bool>()
        let error = PublishSubject<Error>()
        let recipeName = PublishSubject<String>()
        
        searchQuery = searching.asObserver()
        searching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap { recipeSearchUsecase.execute(query: $0) }
            .do(onNext: { _ in activating.onNext(true) })
            .do(onError: error.onNext(_:))
            .subscribe(onNext: recipeList.onNext(_:))
            .disposed(by: disposeBag)
        
        findRecipe = finding.asObserver()
        finding.withLatestFrom(recipeList) { indexPath, recipes in
            return recipes[indexPath]
        }
        .map { $0.name }
        .subscribe(onNext: recipeName.onNext(_:))
        .disposed(by: disposeBag)
        
        recipes = recipeList
        isLoading = activating
        errorMessage = error.map { $0.localizedDescription }
        showDetailPage = recipeName
    }
}
