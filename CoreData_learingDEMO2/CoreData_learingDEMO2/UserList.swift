//
//  UserList.swift
//  CoreData_learingDEMO2
//
//  Created by mac on 3/18/25.
//

import SwiftUI

struct UserList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(
           entity: User.entity(),
           sortDescriptors: [NSSortDescriptor(keyPath: \User.id, ascending: false)],
           animation: .default)
           // 这就是我们获取到 coredata user 的数据
    
    
    private var userList: FetchedResults<User>
    
    
    
    
    var body: some View {
        VStack {
                     if userList.isEmpty {
                       Text("暂无用户数据")
                   } else {
                       ForEach(userList, id: \.self) { item in
                           HStack {
                               Text(item.name)
                               Text("爱好：\(item.hobby)")
                           }
                       }
                   }
               }.navigationTitle("用户列表")
        
        
    }
}





#Preview {
    UserList()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
