//
//  RecipeSearchRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 9/30/24.
//

import Foundation
import RxSwift

protocol RecipeSearchRepository {
    func searchRecipe(query: String) -> Observable<[Recipe]>
}
