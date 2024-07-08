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
    
    func fetchRecipeDetail() -> Observable<RecipeDetail> {
        return repository.fetchAllRecipeDetail()
            .decode(type: RecipeDetailResponseDTO.self, decoder: decoder)
            .map { $0.toDomain() }
    }
    
    func searchRecipe(with query: RecipeQuery) -> Observable<[Recipe]> {
        return repository.searchAllRecipe(with: RecipeRequestDTO(dto: query).query)
            .decode(type: [RecipeResponseDTO].self, decoder: decoder)
            .map { $0.map { $0.toDomain() } }
    }
}
