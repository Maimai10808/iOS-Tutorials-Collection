//
//  CDTask+helper.swift
//  TaskManager
//
//  Created by mac on 3/17/25.
//

import Foundation
import CoreData

extension CDTask {
    
    
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
    
    
    var dueDate: Date {
        get { dueDate_ ?? Date() }
        set { dueDate_ = newValue }
    }
    
    
    convenience init(title: String,
                     dueDate: Date,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.dueDate = dueDate
    }
    
    
    public  override func awakeFromInsert() {
        self.uuid_ = UUID()
    }
    
    
    
    
}
