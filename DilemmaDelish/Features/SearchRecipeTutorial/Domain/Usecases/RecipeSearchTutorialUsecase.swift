//
//  RecipeSearchTutorialUsecase.swift
//  DilemmaDelish
//
//  Created by TORI on 9/24/24.
//

import Foundation
import RxSwift

protocol RecipeSearchTutorialUsecase {
    func execute() -> Observable<RecipeDetail>
}
