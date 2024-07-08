//
//  RecipeRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 7/7/24.
//

import Foundation
import RxSwift

protocol RecipeRepository {
    func fetchAllRecipeDetail() -> Observable<Data>
    func searchAllRecipe(with query: String) -> Observable<Data>
}
