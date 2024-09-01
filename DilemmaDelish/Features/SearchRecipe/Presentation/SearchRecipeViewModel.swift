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
