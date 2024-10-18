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
    
    let searchTerm: AnyObserver<String>
    
    init(coordinator: RecipeSearchCoordinator = Container.shared.resolve(DefaultRecipeSearchCoordinator.self)) {
        let searching = PublishSubject<String>()
        
        searchTerm = searching.asObserver()
        searching
            .map { DefaultRecipeSearchable(name: $0) }
            .subscribe { coordinator.showRecipeSearchResults(from: $0) }
            .disposed(by: disposeBag)
    }
}
