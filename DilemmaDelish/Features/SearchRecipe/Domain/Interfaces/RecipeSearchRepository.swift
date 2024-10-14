//
//  RecipeSearchRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 9/30/24.
//

import Foundation
import RxSwift

protocol RecipeSearchRepository {
    func searchRecipe(from searchable: RecipeSearchable) -> Observable<[Recipe]>
}
