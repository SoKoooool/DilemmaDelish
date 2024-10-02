//
//  RecipeSearchResultDetailViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 10/2/24.
//

import Foundation
import RxSwift

protocol RecipeSearchResultDetailViewModel {
    var recipeName: AnyObserver<String> { get }
    var recipe: Observable<Recipe> { get }
}

public final class DefaultRecipeSearchResultDetailViewModel: RecipeSearchResultDetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    let recipeName: AnyObserver<String>
    
    let recipe: Observable<Recipe>
    
    init(recipeSearchUsecase: RecipeSearchUsecase) {
        let naming = PublishSubject<String>()
        
        let recipeDetail = PublishSubject<Recipe>()
        
        recipeName = naming.asObserver()
        naming
            .map { DefaultRecipeSearchable(name: $0) }
            .map { $0.toQueryString() }
            .flatMap { recipeSearchUsecase.execute(query: $0) }
            .flatMap { Observable.from($0) }
            .subscribe(onNext: recipeDetail.onNext(_:))
            .disposed(by: disposeBag)
        
        recipe = recipeDetail
    }
}
