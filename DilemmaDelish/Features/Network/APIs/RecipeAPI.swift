//
//  RecipeAPI.swift
//  DilemmaDelish
//
//  Created by TORI on 8/19/24.
//

import Foundation
import RxSwift

struct RecipeAPI: APIBase {
    var baseURL: String
    var session: URLSession
    
    struct Recipe: Requestable {
        var path: String = ""
        var method: HTTPMethod = .get
        var headers: [String : String]? = nil
        var parameters: [String : Any]? = nil
        
        struct Response: Decodable {
            let response: [String]
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
    
    func recipe() -> Observable<Recipe.Response> {
        return request(Recipe())
    }
    
    func recipeDetail() -> Observable<RecipeDetail.Response> {
        return request(RecipeDetail())
    }
}
