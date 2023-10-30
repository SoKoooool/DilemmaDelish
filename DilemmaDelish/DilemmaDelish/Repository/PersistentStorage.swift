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
    
    private lazy var context = persistentContainer.viewContext
    
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
    
    typealias FetchResult = Result<[IngredientItem], NSError>
    
    mutating func fetchIngredients() -> FetchResult {
        do {
            let request = IngredientModel.fetchRequest()
            let entities = try context.fetch(request)
            return .success(entities.map { $0.toDomain() })
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
            let entities = try context.fetch(request)
            guard let entity = entities.first else { return }
            context.delete(entity)
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    mutating func deleteAllIngredients() {
        do {
            let request = IngredientModel.fetchRequest()
            let entities = try context.fetch(request)
            entities.forEach { self.context.delete($0) }
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}
