# Twitter_CloneApp技术学习

## 项目链接：`https://github.com/Maimai10808/Twitter-Clone-APP`
## Firebase依赖：`https://github.com/firebase/firebase-ios-sdk`
## 根据我的Twitter_CloneApp,进行一些技术学习

这个帖子主要向大家分享一下本项目的UI亮点和数据处理亮点，由于篇幅有限，我将在下一个帖子详细的讲一下利用 MVVM 来实现每个功能的具体实现。

### UI亮点
1. 侧边栏的丝滑运用
2. 密码输入私密保护机制
3. LazyVStack 提高性能并确保正常工作
4. 利用 enum 来构建 SideMenuOptionRowView

### 数据处理亮点
1. 注册，登入，登出，注销功能
2. 发推，点赞，关注功能



## UI亮点

### 1.侧边栏的丝滑运用

运用 toolbar 和 onAppear 来丝滑展开侧边栏

见 **ContentView.swift**

```swift
        NavigationStack { 
        ...
}
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    } label: {
                        Circle()
                            .frame(width: 32, height: 32)
                    }
                }
            }
            .onAppear {
                showMenu = false
            }
```

### 2. 密码输入私密保护机制

见 **CustomInputField.swift**

```swift
    let placeholderText: String
    var isSecureField: Bool? = false

if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }   
```

### 3. LazyVStack 提高性能并确保正常工作

见 **ExploreView.swift**

```swift
NavigationView {
            ScrollView {
                
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                LazyVStack {
                    // 使用 LazyVStack 提高性能并确保 NavigationLink 正常工作
                    ForEach(viewModel.searchableUsers) { user in
                        NavigationLink(destination: ProfileView(user: user)) {
                            // 确保整个行都是可点击的
                            UserRowView(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }

```

### 4. 利用 enum 来构建 SideMenuOptionRowView

见 **SideMenuViewModel.swift**

```swift
import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case lists
    case bookmarks
    case logout
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .lists: return "Lists"
        case .bookmarks: return "Bookmarks"
        case .logout: return "Logout"
        }
    }
```

见 **SideMenuView.swift**

```swift

ForEach(SideMenuViewModel.allCases, id: \.self) { viewModel in
                
                if viewModel == .profile {
                    if let user = authViewModel.currentUser {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                        
                        
                    } else {
                        SideMenuOptionRowView(viewModel: viewModel)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .opacity(0.5)
                    }


                } else if viewModel == .logout {
                    Button {
                        authViewModel.signOut()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }

                } else {
                    SideMenuOptionRowView(viewModel: viewModel)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
            }


```

见 **SideMenuOptionRowView.swift**

```swift
import SwiftUI

struct SideMenuOptionRowView: View {
    let viewModel: SideMenuViewModel
    var body: some View {
        HStack {
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundStyle(.gray)
            
            
            
            Text(viewModel.title)
                .foregroundStyle(.black)
                .font(.subheadline)
            
            
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

```


## 数据处理亮点

### 本项目运用的是Google的Firebase后端技术

Firebase git clone路径:

` https://github.com/firebase/firebase-ios-sdk`

主要用来处理用户的注册，登入，登出，注销， 发推，点赞，关注的数据交流。

## 0. 创建用户和推文数据库


见 **User.swift**

```swift
import FirebaseFirestore
import Firebase
import FirebaseAuth

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String?
    let email: String
    
    // 计算属性，判断是否为当前用户
        var isCurrentUser: Bool {
            return self.id == Auth.auth().currentUser?.uid
        }
}
```
见 **Tweet.swift**
```swift
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseCore
import Foundation
import FirebaseFirestore



struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    let likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
```

### 1. 注册，登入，登出，注销功能

首先创建 **AuthViewModel.swift**

```swift
import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session is \(self.userSession?.uid)")
        if let uid = self.userSession?.uid {
            self.fetchUser()
        }
    }

}

```
#### 注册功能

共包含5个数据(email, username, fullname, uid, profileImageUrl)
其中email, username, fullname需要用户输入，profileImageUrl为用户上传头像系统自动生成的Url
uid为系统自动生成。

```swift
// register 注册功能
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            print("DEBUG: Successfully created user with uid: \(firebaseUser.uid)")
            
            let data = ["email": email,
                       "username": username.lowercased(),
                       "fullname": fullname,
                       "uid": firebaseUser.uid,
                       "profileImageUrl": NSNull()]
            
            Firestore.firestore().collection("users")
                .document(firebaseUser.uid)
                .setData(data) { error in
                    if let error = error {
                        print("DEBUG: Failed to save user data: \(error.localizedDescription)")
                        return
                    }
                    
                    print("DEBUG: Successfully saved user data")
                    self.userSession = firebaseUser
                    self.didAuthenticateUser = true
                    self.fetchUser()
                }
        }
    }
```

#### 登入功能

```swift
// login 登入功能
    func login(withEmail email : String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.didAuthenticateUser = false
            self.fetchUser()
        }
    }

```

#### 登出功能

```swift
func signOut() {
        userSession = nil
        didAuthenticateUser = false
        currentUser = nil
        try? Auth.auth().signOut()
    }

```


#### ~~头像上传功能~~  

由于firebase上传图片需要订阅才能解锁上传，本人财力有限，无奈只能放弃图片上传功能。
下面是代码，欢迎诸位一起交流，如有错误，还请斧正。

```swift
func uploadProfileImage(_ image: UIImage) {
     guard let uid = userSession?.uid else {
         self.uploadError = "User session not found"
         return
     }
     
     isUploadingProfileImage = true
     uploadError = nil
     
     ImageUploader.uploadImage(image: image) { [weak self] profileImageUrl in
         guard let self = self else { return }
         
         Firestore.firestore().collection("users")
             .document(uid)
             .updateData(["profileImageUrl": profileImageUrl]) { error in
                 if let error = error {
                     self.uploadError = error.localizedDescription
                     print("DEBUG: Failed to update profile image URL: \(error.localizedDescription)")
                     self.isUploadingProfileImage = false
                     return
                 }
                 
                 print("DEBUG: Successfully updated profile image URL")
                 self.isUploadingProfileImage = false
                 self.didAuthenticateUser = false
                 self.fetchUser()
             }
     }
 }

```

见 **ImagePicker.swift**


```swift

import SwiftUI

// 1. ImagePicker 选择图片配置
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    // 创建协调器
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // 创建UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary  // 设置图片来源为图库
        picker.allowsEditing = false // 是否允许编辑
        return picker
    }
    
    // 更新UIViewController，不需要在这个方法里做任何操作
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// Coordinator 类：处理UIImagePickerController的代理方法
extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        // 选择图片后的回调
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            parent.selectedImage = image  // 将选中的图片传递给绑定的变量
            parent.presentationMode.wrappedValue.dismiss()  // 关闭 picker
        }
        
        // 取消选择图片后的回调
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()  // 关闭 picker
        }
    }
}
```


#### 以下是**AuthViewModel.swift**

```swift
import SwiftUI
import Firebase
import FirebaseAuth



class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var isUploadingProfileImage = false
    @Published var uploadError: String?
    @Published var currentUser: User?
    
    // 2.AuthViewModel
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session is \(self.userSession?.uid)")
        if let uid = self.userSession?.uid {
            self.fetchUser()
        }
    }
    
    // login 登入功能
    func login(withEmail email : String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.didAuthenticateUser = false
            self.fetchUser()
        }
    }
    
    // register 注册功能
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            print("DEBUG: Successfully created user with uid: \(firebaseUser.uid)")
            
            let data = ["email": email,
                       "username": username.lowercased(),
                       "fullname": fullname,
                       "uid": firebaseUser.uid,
                       "profileImageUrl": NSNull()]
            
            Firestore.firestore().collection("users")
                .document(firebaseUser.uid)
                .setData(data) { error in
                    if let error = error {
                        print("DEBUG: Failed to save user data: \(error.localizedDescription)")
                        return
                    }
                    
                    print("DEBUG: Successfully saved user data")
                    self.userSession = firebaseUser
                    self.didAuthenticateUser = true
                    self.fetchUser()
                }
        }
    }
    
    
    func signOut() {
        userSession = nil
        didAuthenticateUser = false
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    
    
    
    
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}

```

###  2.发推，点赞，关注功能

#### 发推

见 **TweetService.swift**

首先创建**TweetService.swift**

```swift
import Foundation
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

struct TweetService {

}

```

加入 uploadTweet功能

```swift
func uploadTweet(caption: String, completion: @escaping(Bool) -> Void)  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                print("DEBUG: Successfully uploaded tweet")
                completion(true)
            }
    }

```

加入 fetchTweets功能，为后续加载Tweets做准备。

Home界面
```swift
func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        print("DEBUG: Fetching all tweets...")
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents found")
                    return
                }
                
                print("DEBUG: Found \(documents.count) tweets")
                let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                print("DEBUG: Successfully decoded \(tweets.count) tweets")
                completion(tweets)
            }
    }

```


```swift
func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        print("DEBUG: Fetching tweets for user \(uid)...")
        
        // 临时解决方案：先获取所有推文，然后在内存中过滤
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents found")
                    return
                }
                
                print("DEBUG: Found \(documents.count) total tweets")
                let allTweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                let userTweets = allTweets.filter { $0.uid == uid }
                print("DEBUG: Found \(userTweets.count) tweets for user \(uid)")
                completion(userTweets)
            }
    }

```
#### 喜欢功能(+取消喜欢)

```swift
func likeTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        userLikesRef.document(tweetId).getDocument { snapshot, _ in
            if let snapshot = snapshot, snapshot.exists {
                // 如果已经点赞，则取消点赞
                userLikesRef.document(tweetId).delete { _ in
                    Firestore.firestore().collection("tweets").document(tweetId).updateData([
                        "likes": FieldValue.increment(Int64(-1))
                    ]) { _ in
                        completion(false)
                    }
                }
            } else {
                // 如果未点赞，则添加点赞
                userLikesRef.document(tweetId).setData([:]) { _ in
                    Firestore.firestore().collection("tweets").document(tweetId).updateData([
                        "likes": FieldValue.increment(Int64(1))
                    ]) { _ in
                        completion(true)
                    }
                }
            }
        }
    }

```
筛选用户喜欢的推文

```swift
func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes").document(tweetId).getDocument { snapshot, _ in
            completion(snapshot?.exists ?? false)
        }
    }

func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        print("DEBUG: Fetching liked tweets for user \(uid)")
        
        // 1. 首先获取用户点赞的推文ID
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch liked tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No liked tweets found")
                    completion([])
                    return
                }
                
                print("DEBUG: Found \(documents.count) liked tweets")
                
                // 2. 获取所有点赞的推文ID
                let tweetIDs = documents.map { $0.documentID }
                
                // 3. 获取每个推文的详细信息
                var tweets = [Tweet]()
                let group = DispatchGroup()
                
                for tweetID in tweetIDs {
                    group.enter()
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, error in
                            defer { group.leave() }
                            
                            if let error = error {
                                print("DEBUG: Failed to fetch tweet \(tweetID) with error: \(error.localizedDescription)")
                                return
                            }
                            
                            if let tweet = try? snapshot?.data(as: Tweet.self) {
                                tweets.append(tweet)
                            }
                        }
                }
                
                group.notify(queue: .main) {
                    completion(tweets)
                }
            }
    }

```
以下是**TweetService.swift**

```swift
import Foundation
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore


struct TweetService {
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void)  {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                print("DEBUG: Successfully uploaded tweet")
                completion(true)
            }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        print("DEBUG: Fetching all tweets...")
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents found")
                    return
                }
                
                print("DEBUG: Found \(documents.count) tweets")
                let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                print("DEBUG: Successfully decoded \(tweets.count) tweets")
                completion(tweets)
            }
    }
    
    func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        print("DEBUG: Fetching tweets for user \(uid)...")
        
        // 临时解决方案：先获取所有推文，然后在内存中过滤
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents found")
                    return
                }
                
                print("DEBUG: Found \(documents.count) total tweets")
                let allTweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
                let userTweets = allTweets.filter { $0.uid == uid }
                print("DEBUG: Found \(userTweets.count) tweets for user \(uid)")
                completion(userTweets)
            }
    }
    
    func likeTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        userLikesRef.document(tweetId).getDocument { snapshot, _ in
            if let snapshot = snapshot, snapshot.exists {
                // 如果已经点赞，则取消点赞
                userLikesRef.document(tweetId).delete { _ in
                    Firestore.firestore().collection("tweets").document(tweetId).updateData([
                        "likes": FieldValue.increment(Int64(-1))
                    ]) { _ in
                        completion(false)
                    }
                }
            } else {
                // 如果未点赞，则添加点赞
                userLikesRef.document(tweetId).setData([:]) { _ in
                    Firestore.firestore().collection("tweets").document(tweetId).updateData([
                        "likes": FieldValue.increment(Int64(1))
                    ]) { _ in
                        completion(true)
                    }
                }
            }
        }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes").document(tweetId).getDocument { snapshot, _ in
            completion(snapshot?.exists ?? false)
        }
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        print("DEBUG: Fetching liked tweets for user \(uid)")
        
        // 1. 首先获取用户点赞的推文ID
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch liked tweets with error: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No liked tweets found")
                    completion([])
                    return
                }
                
                print("DEBUG: Found \(documents.count) liked tweets")
                
                // 2. 获取所有点赞的推文ID
                let tweetIDs = documents.map { $0.documentID }
                
                // 3. 获取每个推文的详细信息
                var tweets = [Tweet]()
                let group = DispatchGroup()
                
                for tweetID in tweetIDs {
                    group.enter()
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, error in
                            defer { group.leave() }
                            
                            if let error = error {
                                print("DEBUG: Failed to fetch tweet \(tweetID) with error: \(error.localizedDescription)")
                                return
                            }
                            
                            if let tweet = try? snapshot?.data(as: Tweet.self) {
                                tweets.append(tweet)
                            }
                        }
                }
                
                group.notify(queue: .main) {
                    completion(tweets)
                }
            }
    }
    
    
}

```
#### 关注功能(取消关注)

见 **ProfileViewModel.swift**
```swift
import Foundation
import Firebase
import FirebaseAuth


class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]() // 存储用户喜欢的推文
    @Published var isFollowing: Bool = false // 是否已关注该用户
    
    let service = TweetService()
    let userService = UserService()
    
    var user: User? // 用来保存当前的 `User` 对象
    
    // 计算属性，根据是否是当前用户来设置按钮标题
    var actionButtonTitle: String {
        guard let user = user else {
            return "Follow" // 如果没有用户信息，就显示“Follow”按钮
        }
        return user.isCurrentUser ? "Edit Profile" : (isFollowing ? "Unfollow" : "Follow")
    }
    
    func fetchUserTweets(forUid uid: String) {
        print("DEBUG: Fetching tweets for user \(uid)")
        service.fetchTweets(forUid: uid) { tweets in
            self.tweets = tweets
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
    
    // 获取用户喜欢的推文
    func fetchLikedTweets(forUid uid: String) {
        print("DEBUG: Fetching liked tweets for user \(uid)")
        service.fetchLikedTweets(forUid: uid) { tweets in
            self.likedTweets = tweets
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
        }
    }
    
    // 关注该用户
    func followUser() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let userIdToFollow = user?.id else { return }
        
        // 更新数据库：将该用户加入当前用户的“关注”列表
        Firestore.firestore().collection("users").document(currentUserId).collection("following").document(userIdToFollow).setData([:]) { error in
            if let error = error {
                print("DEBUG: Failed to follow user: \(error.localizedDescription)")
                return
            }
            self.isFollowing = true
            print("DEBUG: Successfully followed user.")
        }
    }
    
    // 取消关注该用户
    func unfollowUser() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let userIdToUnfollow = user?.id else { return }
        
        // 更新数据库：将该用户从当前用户的“关注”列表中移除
        Firestore.firestore().collection("users").document(currentUserId).collection("following").document(userIdToUnfollow).delete { error in
            if let error = error {
                print("DEBUG: Failed to unfollow user: \(error.localizedDescription)")
                return
            }
            self.isFollowing = false
            print("DEBUG: Successfully unfollowed user.")
        }
    }
    
    // 检查当前用户是否已关注该用户
    func checkIfUserIsFollowing() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.id else { return }
        
        Firestore.firestore().collection("users").document(currentUserId).collection("following").document(userId).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to check following status: \(error.localizedDescription)")
                return
            }
            self.isFollowing = snapshot?.exists ?? false
        }
    }
}
```

## 总结

下一个帖子我将详细的根据 MVVM 框架来向大家讲述每个功能(注册，登入，登出，注销， 发推，点赞，关注)的具体实现。




















