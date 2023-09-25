//
//  PersistentStorage.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/25.
//

import Foundation
import CoreData

struct PersistentStorage {
    
    static var shared = PersistentStorage()
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IngredientModel.xcdatamodeld")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    mutating func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension PersistentStorage {
    
    typealias FetchResult = Result<[IngredientModel], NSError>
    
    mutating func fetch() -> FetchResult {
        do {
            let request = IngredientModel.fetchRequest()
            let models = try context.fetch(request)
            return .success(models)
        } catch {
            print(error.localizedDescription)
            return .failure(error as NSError)
        }
    }
}
