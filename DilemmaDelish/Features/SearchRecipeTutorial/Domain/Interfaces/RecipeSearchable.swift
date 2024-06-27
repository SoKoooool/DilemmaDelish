//
//  RecipeSearchable.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeSearchable {
    func fetchRecipeDetail() -> Observable<RecipeDetail>
}
