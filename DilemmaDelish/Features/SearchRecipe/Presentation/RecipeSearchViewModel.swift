//
//  SearchRecipeViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 9/1/24.
//

import Foundation
import RxSwift

protocol RecipeSearchViewModel {
    var searchTerm: AnyObserver<String> { get }
    var showSearchResultPage: Observable<String> { get }
}

public final class DefaultRecipeSearchViewModel: RecipeSearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    let searchTerm: AnyObserver<String>
    let showSearchResultPage: Observable<String>
    
    init() {
        let searching = PublishSubject<String>()
        let searchQuery = PublishSubject<String>()
        
        searchTerm = searching.asObserver()
        searching
            .map { DefaultRecipeSearchable(name: $0) }
            .map { $0.toQueryString() }
            .subscribe(onNext: searchQuery.onNext(_:))
            .disposed(by: disposeBag)
        
        showSearchResultPage = searchQuery
    }
}
