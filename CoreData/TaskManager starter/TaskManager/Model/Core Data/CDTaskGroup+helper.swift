//
//  CDTaskGroup+helper.swift
//  TaskManager
//
//  Created by mac on 3/17/25.
//

import Foundation
import CoreData



extension CDTaskGroup {
    
    var uuid: UUID {
        
     #if DEBUG
        uuid_!
        
     #else
        uuid_ ?? UUID()
     #endif
    }
    
    var title: String {
        
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var creationDate: Date {
        
        creationDate_ ?? Date()
    }
    
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
    }
    
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
        self.creationDate_ = Date()
    }
    
    
    
}
