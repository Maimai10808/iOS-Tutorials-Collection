//
//  TransactionItem+CoreDataProperties.swift
//  Income
//
//  Created by mac on 7/31/25.
//
//

public import Foundation
public import CoreData


public typealias TransactionItemCoreDataPropertiesSet = NSSet

extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var type: Int16
    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?

}

extension TransactionItem : Identifiable {

}


extension TransactionItem {
    var wrappedTitle: String {
        title ?? ""
    }

    var wrappedDate: Date {
        date ?? Date()
    }

    var wrappedId: UUID {
        id! // 必须有，否者不是有效 transaction，可 crash 提醒开发者
    }

    var wrappedType: TransactionType {
        TransactionType(rawValue: Int(type)) ?? .expense // 默认 fallback
    }

    var wrappedAmount: Double {
        amount // 已非 optional
    }
}
