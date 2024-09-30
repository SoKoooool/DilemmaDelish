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
}

public final class DefaultRecipeSearchViewModel: RecipeSearchViewModel {
    
    private let disposeBag = DisposeBag()
    private let usecase: SearchRecipeUsecase
    
    let searchTerm: AnyObserver<String>
    
    let showSearchResultPage: Observable<String>
    
    init(usecase: SearchRecipeUsecase) {
        self.usecase = usecase
        
        let searching = PublishSubject<String>()
        let searchQuery = PublishSubject<String>()
        
        searchTerm = searching.asObserver()
        showSearchResultPage = searchQuery
    }
}
