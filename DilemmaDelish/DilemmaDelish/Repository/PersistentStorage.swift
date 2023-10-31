//
//  PersistentStorage.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/09/25.
//

import Foundation
import CoreData
import RxSwift

protocol RepositoryProtocol {
    func create(item: IngredientItem)
    func read(from item: IngredientItem) -> Observable<IngredientModel>
    func readEntities() -> Observable<[IngredientModel]>
    func update(item: IngredientItem)
    func delete(item: IngredientItem)
    func deleteAllItems()
}

final class PersistentStorage {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
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
    
    private func saveContext () {
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

extension PersistentStorage: RepositoryProtocol {

    func create(item: IngredientItem) {
        let entity = IngredientModel(context: context)
        entity.name = item.name
        entity.imageName = item.imageName
        saveContext()
    }
    
    func read(from item: IngredientItem) -> Observable<IngredientModel> {
        return readEntities()
            .map { $0.filter { $0.name == item.name }.first }
            .flatMap { Observable.from(optional: $0) }
    }
    
    func readEntities() -> Observable<[IngredientModel]> {
        return Observable.create { [weak self] emitter in
            do {
                let request = IngredientModel.fetchRequest()
                guard let entities = try self?.context.fetch(request) else { return }
                emitter.onNext(entities)
                emitter.onCompleted()
            } catch {
                emitter.onError(error)
            }
        }
    }
    
    func update(item: IngredientItem) {
        read(from: item)
            .subscribe {
                $0.name = item.name
                $0.imageName = item.imageName
                self.saveContext()
            }
            .disposed(by: disposeBag)
    }
    
    func delete(item: IngredientItem) {
        read(from: item)
            .subscribe {
                self.context.delete($0)
                self.saveContext()
            }
            .disposed(by: disposeBag)
    }
    
    func deleteAllItems() {
        readEntities()
            .subscribe {
                $0.forEach { self.context.delete($0) }
                self.saveContext()
            }
            .disposed(by: disposeBag)
    }
}
