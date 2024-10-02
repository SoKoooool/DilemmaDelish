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
