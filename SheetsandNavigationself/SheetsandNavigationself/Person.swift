//
//  Person.swift
//  SheetsandNavigationself
//
//  Created by mac on 7/26/25.
//

import Foundation

struct Person: Identifiable, Hashable {
    let id = UUID()
    let name: String
}
