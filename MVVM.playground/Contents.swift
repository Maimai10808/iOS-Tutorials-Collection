/*:
 ## MVVM
 
 MVVM stands for Model View ViewModel and this is a way of structuring our code to seperate logic from the user interface.
 
 ![mvvm](mvvm.png)
 
 ### Benefits of MVVM
 
 1. App's are easier to manage and scale.
 2. App's are easier to test.
 3. Higher reusability of code.
 
 ### MVVM Components
 
 An app built using MVVM is comprised of a Model, a ViewModel and a View.
 
 #### Model
 
 A Model represents the data of our application. You typically build your Model as a Structure. The following is an example of a User model.
 
    struct User: Identifiable {
        let id: String
        let username: String
        let email: String
    }
 
 The Model will communicate with the ViewModel and lacks awareness of the View.
 
 #### ViewModel
 
 A ViewModel stands between the Model and the View. The ViewModel is responsible for providing data from the Model to the Views. It is also responsible for handling interactions with inputs (e.g TextField) and control (e.g Button) through Binding.
 
 A ViewModel in SwiftUI will be a class that conforms to ObservableObject. An instance of the ViewModel will exist in the View as a StateObject.
 
    class UsersViewModel: ObservableObject {
        @Published var users: [User] = []
    }
 
 The @Published attribute is derived from Combine. It is used in a SwiftUI ViewModel as a means of holding state.
 
 #### View
 
 The View is the user interface itself.
 
     struct ContentView: View {
 
         @StateObject var viewModel = UsersViewModel()
         
         var body: some View {
             List(viewModel.users) { user in
                 Text(user.name)
             }
         }
     }
 
 ### ObservableObject
 
 Any class that conforms to the ObservableObject protocol has the ability to notify views that there has been a change in the data that they are observing. Any properties that are marked with @Published in the class that conforms to ObservableObject will automatically update the view to update when changed.
 
 ### StateObject
 
 According to Apple's documentation, @StateObject is a property wrapper that instatiates an observable object. This means an property that is marked with @StateObject holds onto a value that conforms to the ObservableObject protocol. It is referred to as the single source of truth because it can be shared across different views as an ObservedObject.
 
 ### ObservedObject
 
 @ObservedObject is a property wrapper that behaves a lot like a @Binding. They hold onto a value that conforms to the ObservableObject protocol but they are meant to hold onto an instance passed in from another view. Therefore, if you wish to pass an instance of a property instantiated with @StateObject it would use @ObservedObject in the other view.
 
 */
