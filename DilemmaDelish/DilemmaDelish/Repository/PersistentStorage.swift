//
//  PersistentStorage.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/25.
//

import Foundation
import CoreData

struct PersistentStorage {
    
    // MARK: - Properties
    
    static var shared = PersistentStorage()
    private lazy var context = persistentContainer.viewContext
    
    init() {}
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IngredientModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    mutating private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Persistent Storage API

extension PersistentStorage {
    
    typealias FetchResult = Result<[IngredientModel], NSError>
    
    mutating func fetchIngredients() -> FetchResult {
        do {
            let request = IngredientModel.fetchRequest()
            let models = try context.fetch(request)
            return .success(models)
        } catch {
            print(error.localizedDescription)
            return .failure(error as NSError)
        }
    }
    
    mutating func storeIngredient(item: IngredientItem) {
        let entity = IngredientModel(context: context)
        entity.name = item.name
        entity.imageName = item.imageName
        saveContext()
    }
    
    mutating func deleteIngredient(item: IngredientItem) {
        do {
            let request = IngredientModel.fetchRequest()
            let models = try context.fetch(request)
            guard let model = models.first else { return }
            context.delete(model)
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}
