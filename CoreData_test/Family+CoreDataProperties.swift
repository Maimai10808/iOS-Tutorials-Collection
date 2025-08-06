//
//  Family+CoreDataProperties.swift
//  CoreData_test
//
//  Created by mac on 3/16/25.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }


}

extension Family : Identifiable {

}
