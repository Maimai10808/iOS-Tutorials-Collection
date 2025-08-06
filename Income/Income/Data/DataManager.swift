//
//  DataManager.swift
//  Income
//
//  Created by mac on 7/31/25.
//

import Foundation
import CoreData


// Singleton
class DataManager {
    
    static let shared = DataManager()
    /*
     1. 全局唯一实例（Singleton Pattern）
         •    保证 DataManager 类只被创建一次。
         •    shared 是全局唯一的、可共享的实例。

     🧠 类似概念：

     你 App 中只需要有一套 “数据库连接与控制中心”，而不是到处都创建一套重复的 Core Data 系统。
     */
    
    let container = NSPersistentContainer(name: "IncomeData")
    
    private init() {
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("✅ Core Data store loaded: \(storeDescription)")
            }
        }
    }
    
}
