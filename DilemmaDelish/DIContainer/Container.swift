//
//  AppDIContainer.swift
//  DilemmaDelish
//
//  Created by TORI on 10/10/24.
//

import Foundation

public final class Container {
    
    static let shared = Container()
    
    private init() {}
    
    private var dependencies = [String: Any]()
    
    func register<T>(_ dependency: T) {
        let key = String(describing: type(of: T.self))
        dependencies[key] = dependency
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        let dependency = dependencies[key]
        
        precondition(dependency != nil, "Dependency registration missing: \(key)")
        
        return dependency as! T
    }
}
