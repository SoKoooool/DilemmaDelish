//
//  SearchRecipeViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 9/1/24.
//

import Foundation
import RxSwift

protocol SearchRecipeViewModel {
    var searchQuery: AnyObserver<String> { get }
    var recipes: Observable<[Recipe]> { get }
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
}

public final class DefaultSearchRecipeViewModel: SearchRecipeViewModel {
    
    private let disposeBag = DisposeBag()
    private let usecase: SearchRecipeUsecase
    
    var searchQuery: AnyObserver<String>
    
    var recipes: Observable<[Recipe]>
    var isLoading: Observable<Bool>
    var errorMessage: Observable<String>
    
    init(usecase: SearchRecipeUsecase) {
        self.usecase = usecase
        
        let searching = PublishSubject<String>()
        let searchResults = PublishSubject<[Recipe]>()
        let activating = PublishSubject<Bool>()
        let error = PublishSubject<String>()
    
        searchQuery = searching.asObserver()
        searching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap { usecase.execute(query: $0) }
            .do(onNext: { _ in activating.onNext(false) })
            .do(onError: { error.onNext($0.localizedDescription) })
            .subscribe(onNext: searchResults.onNext)
            .disposed(by: disposeBag)
            
        recipes = searchResults.asObserver()
        isLoading = activating.asObserver()
        errorMessage = error.asObserver()
    }
}
