//
//  CookbookViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/30.
//

import Foundation
import RxSwift

protocol CookbookViewModelProtocol {
    var fetchRecipes: AnyObserver<Void> { get }
    var addIngredient: AnyObserver<IngredientItem> { get }
    var subtractIngredient: AnyObserver<IngredientItem> { get }
}

final class CookbookViewModel: CookbookViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    let fetchRecipes: AnyObserver<Void>
    let addIngredient: AnyObserver<IngredientItem>
    let subtractIngredient: AnyObserver<IngredientItem>
    
    init() {
        let fetching = PublishSubject<Void>()
        let adding = PublishSubject<IngredientItem>()
        let subtracting = PublishSubject<IngredientItem>()
        
        fetchRecipes = fetching.asObserver()
        addIngredient = adding.asObserver()
        subtractIngredient = subtracting.asObserver()
    }
}
