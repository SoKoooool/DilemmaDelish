//
//  RecipeSearchTutorialRepository.swift
//  DilemmaDelish
//
//  Created by TORI on 7/7/24.
//

import Foundation
import RxSwift

protocol RecipeSearchTutorialRepository {
    func fetchRecipeDetail() -> Observable<RecipeDetail>
}
