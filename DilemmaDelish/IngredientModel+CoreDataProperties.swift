//
//  IngredientModel+CoreDataProperties.swift
//  DilemmaDelish
//
//  Created by TORI on 2023/10/10.
//
//

import Foundation
import CoreData


extension IngredientModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientModel> {
        return NSFetchRequest<IngredientModel>(entityName: "IngredientModel")
    }

    @NSManaged public var imageName: String
    @NSManaged public var name: String

    func toDomain() -> IngredientItem {
        return IngredientItem(name: name, imageName: imageName)
    }
}

extension IngredientModel : Identifiable {

}
