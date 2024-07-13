//
//  RecipeSearchable.swift
//  DilemmaDelish
//
//  Created by TORI on 6/27/24.
//

import Foundation
import RxSwift

protocol RecipeSearchable {
    func fetchRecipeDetail() -> Observable<ViewRecipeDetail>
    func searchRecipe(with query: RecipeQuery) -> Observable<[Recipe]>
}

final class RecipeStore: RecipeSearchable {
    
    private let repository: RecipeRepository
    private let decoder: JSONDecoder
    
    private let disposeBag = DisposeBag()
    
    init(repository: RecipeRepository, decoder: JSONDecoder) {
        self.repository = repository
        self.decoder = decoder
    }
    
    func fetchRecipeDetail() -> Observable<ViewRecipeDetail> {
        return repository.fetchAllRecipeDetail()
            .map { ViewRecipeDetail($0) }
    }
    
    func searchRecipe(with query: RecipeQuery) -> Observable<[Recipe]> {
        return repository.searchAllRecipe(request: RecipeRequestDTO(query))
            .decode(type: [RecipeResponseDTO].self, decoder: decoder)
            .map { $0.map { $0.toDomain() } }
    }
}
