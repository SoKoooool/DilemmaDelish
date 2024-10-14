//
//  RecipeAPI.swift
//  DilemmaDelish
//
//  Created by TORI on 8/19/24.
//

import Foundation
import RxSwift

struct RecipeAPI: APIBase {
    var baseURL: String = ""
    var session: URLSession = .shared
    
    struct Recipe: Requestable {
        var path: String = ""
        var method: HTTPMethod = .get
        var headers: [String : String]? = nil
        var parameters: [String : Any]? = nil
        
        struct Response: Decodable {
            let dto: [DTO]
            
            struct DTO: Decodable {
                let name: String
                let directions: [String]
                let ingredients: [String]
                let seasonings: [String]
            }
        }
    }

    struct RecipeDetail: Requestable {
        var path: String = ""
        var method: HTTPMethod = .get
        var headers: [String : String]? = nil
        var parameters: [String : Any]? = nil
        
        struct Response: Decodable {
            let response: [String]
        }
    }
    
    func recipe(with query: String) -> Observable<Recipe.Response> {
        return request(Recipe(path: "" + query))
    }
    
    func recipeDetail() -> Observable<RecipeDetail.Response> {
        return request(RecipeDetail())
    }
}
