//
//  ContentView.swift
//  CoreData_learingDEMO
//
//  Created by mac on 3/18/25.
//

import SwiftUI
import CoreData

struct UserListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //2.再新增一个 @Environment 属性，下面的增删改查功能都会用到 viewContext。
    
    
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.id, ascending: false)],
        animation: .default)
    // 这就是我们获取到 coredata user 的数据
    private var userList: FetchedResults<User>
    
    //3.为了在 UserList 视图中显示用户列表数据，我们需要使用 @FetchRequest 来获取数据：
    
    
    
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
        }
        .navigationTitle("UserList")
        
    }
}





#Preview {
    let controller = PersistenceController.preview
    let context = controller.container.viewContext
    
    // 添加一些测试数据
    let newUser = User(context: context)
    newUser.id = UUID()
    newUser.name = "测试用户"
    newUser.hobby = "编程"
    
    try? context.save()
    
    return UserListView()
        .environment(\.managedObjectContext, context)
}
