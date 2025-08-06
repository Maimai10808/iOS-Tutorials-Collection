//
//  User.swift
//  CoreData_learingDEMO
//
//  Created by mac on 3/18/25.
//


import Foundation
import CoreData



final class User: NSManagedObject {
    @NSManaged var id: UUID
    // 用户名
    @NSManaged var name: String
    // 爱好
    @NSManaged var hobby: String
}
