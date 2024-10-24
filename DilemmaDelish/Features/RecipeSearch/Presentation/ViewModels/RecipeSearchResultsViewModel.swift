//
//  RecipeSearchResultsViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 9/30/24.
//

import Foundation
import RxSwift

protocol RecipeSearchResultsViewModel {
    var searchQuery: AnyObserver<String> { get }
    var showRecipeDetail: AnyObserver<String> { get }
    
    var recipeResults: Observable<[Recipe]> { get }
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
}

public final class DefaultRecipeSearchResultsViewModel: RecipeSearchResultsViewModel {
    
    private let disposeBag = DisposeBag()
    
    let searchQuery: AnyObserver<String>
    let showRecipeDetail: AnyObserver<String>
    
    let recipeResults: Observable<[Recipe]>
    let isLoading: Observable<Bool>
    let errorMessage: Observable<String>
    
    init(recipeSearchUsecase: RecipeSearchUsecase = Container.shared.resolve(DefaultRecipeSearchUsecase.self),
         coordinator: RecipeSearchCoordinator = Container.shared.resolve(DefaultRecipeSearchCoordinator.self)) {
        let searching = PublishSubject<String>()
        let detailing = PublishSubject<String>()
        
        let recipes = PublishSubject<[Recipe]>()
        let activating = PublishSubject<Bool>()
        let error = PublishSubject<Error>()
        
        searchQuery = searching.asObserver()
        searching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap { recipeSearchUsecase.execute($0) }
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
