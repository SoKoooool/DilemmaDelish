//
//  CookbookViewModel.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/30.
//

import Foundation
import RxSwift

protocol CookbookViewModelProtocol {
    var searchRecipe: AnyObserver<Void> { get }
    var addIngredient: AnyObserver<IngredientItem> { get }
    var subtractIngredient: AnyObserver<IngredientItem> { get }
    
    var onIngredients: Observable<[IngredientItem]> { get }
    var onRecipes: Observable<[RecipeItem]> { get }
}

final class CookbookViewModel: CookbookViewModelProtocol {
    
    private let service: RecipeSearchServiceProtocol!
    private let disposeBag = DisposeBag()
    
    let searchRecipe: AnyObserver<Void>
    let addIngredient: AnyObserver<IngredientItem>
    let subtractIngredient: AnyObserver<IngredientItem>
    
    let onIngredients: Observable<[IngredientItem]>
    let onRecipes: Observable<[RecipeItem]>
    
    init(service: RecipeSearchServiceProtocol = RecipeSearchService()) {
        self.service = service
        
        let searching = PublishSubject<Void>()
        let adding = PublishSubject<IngredientItem>()
        let subtracting = PublishSubject<IngredientItem>()
        
        let ingredients = PublishSubject<[IngredientItem]>()
        let recipes = PublishSubject<[RecipeItem]>()
        
        searchRecipe = searching.asObserver()
        addIngredient = adding.asObserver()
        subtractIngredient = subtracting.asObserver()
        
        onIngredients = ingredients.asObserver()
        onRecipes = recipes.asObserver()
    }
}
