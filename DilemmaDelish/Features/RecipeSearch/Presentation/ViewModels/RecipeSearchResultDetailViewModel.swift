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
    var recipeDetail: Observable<Recipe> { get }
}

public final class DefaultRecipeSearchResultDetailViewModel: RecipeSearchResultDetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    let recipeName: AnyObserver<String>
    
    let recipeDetail: Observable<Recipe>
    
    init(recipeSearchUsecase: RecipeSearchUsecase) {
        let naming = PublishSubject<String>()
        
        let recipe = PublishSubject<Recipe>()
        
        recipeName = naming.asObserver()
        naming
            .map { DefaultRecipeSearchable(name: $0) }
            .flatMap { recipeSearchUsecase.execute(from: $0) }
            .flatMap { Observable.from($0) }
            .subscribe(onNext: recipe.onNext(_:))
            .disposed(by: disposeBag)
        
        recipeDetail = recipe
    }
}
