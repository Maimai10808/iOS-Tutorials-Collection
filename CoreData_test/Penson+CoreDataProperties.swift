//
//  Penson+CoreDataProperties.swift
//  CoreData_test
//
//  Created by mac on 3/16/25.
//
//

import Foundation
import CoreData


extension Penson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Penson> {
        return NSFetchRequest<Penson>(entityName: "Penson")
    }

    @NSManaged public var age: Int64
    @NSManaged public var name: String?

}

extension Penson : Identifiable {

}
