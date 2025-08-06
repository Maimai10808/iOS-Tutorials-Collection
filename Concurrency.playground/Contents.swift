/*:
 
## Concurrency
 
 Concurrency is the ability of our code to run multiple tasks at the same time. The reasoning for this is that it makes our code more efficient. The tasks themselves are split up and run on threads. Our user interface typically works on the the main thread. This thread is particularly dedicated to keeping our user interface responsive to user interactions like button taps and scrolling. However, other processes may be initiated. For example, let's say a user attempts to log in to the app. This action may require making a network call to a remote server to validate the user's credentials. The network call will take time and consume resources to complete. We would not want this to run on our main thread because that would ultimately block the thread from responding to user interactions. Therefore, it makes sense to move the task of completing the network call to a different thread often referred to as a background thread.
 
 ### Threads and Queues
 
 The work that takes place on a thread is referred to as a queue. Much like the term implies, the tasks are executed in a particular order. A serial queue will execute the tasks in the order they are presented. This is important for tasks where order and safety are neccessary. On the other end are concurrent queues. These may pause, resume, stop or manage different tasks all at the same time. Often times a priority is attatched to the tasks running in a queue which affects the order in which they are completed. High priority tasks take precedence over lower priority tasks.
 
 All the work on threads and queues happens on our device's CPU. The CPU of course is the main logical center of our device. When we talk about concurrency, we are referring to the way the CPU is able to manage many tasks at once. A CPU will often come with many different cores. The work on each core is happening concurrently and the many cores working together are doing work in parellel to each other. Although Apple provides APIs to create and manage threads and queues often times you will use system defaults because things can quickly become complex and lead to errors.
 
 ### Asynchronous vs Synchronous
 
 At a code level, we talk about our code running asynchronously or synchronously. Our code runs synchronously most of the time which means one thing needs to complete before another. Code that runs asynchronously runs at the same time as other code. Apps that support network calls need the calls to run asynchrously or else the app freezes until the network call is complete. Network calls involve a process of making a request to a server and waiting for some kind of response. Consider the following example.
 
*/

import Foundation

print("Before the network call")

//closure

//Network call the star wars api
URLSession.shared.downloadTask(with: URLRequest(url: URL(string: "https://swapi.dev/api/people/1")!)) { _, _, _ in
    print("Inside the network call")
}.resume()

print("After the network call")

/*:
 
 The code above makes a network call to the Star Wars API requesting information on the charatcer Luke Skywalker. If you follow the print statments you would expect to see them in the order:
 
    1. Before the network call
    2. Inside the network call
    3. After the network call
 
 The actual order is as follows:
 
    1. Before the network call
    2. After the network call
    3. Inside the network call
 
 The reason for this is that the network call takes time to complete. The rest of our code does not wait for the network call to get back a response and simply continues. The network code and the rest of the code execute at the same time and are said to happen asynchronously.
 
 ### Async/Await and Task
 
 Async/await allow asynchronous code to run as if it were synchronous. The code has not become synchronous but it frees us from using completion handlers to know when asynchronous code has eneded. Async is a keyword used to mark a function as running asynchronous code. Await is a keyword used to make code "wait" for an asynchronous function to complete before moving on. Task is used to run an asynchronous function by creating an asynchronous context. With async/await we can rewrite our first example to  run our network code and print the statements in order.
 
 */

func runAsyncCode() async {
    print("Before the network call")
    do {
        print("Inside the network call")
        try await URLSession.shared.download(from: URL(string: "https://swapi.dev/api/people/1")!)
    } catch {
        
    }
    print("After the network call")
    
}

Task {
    await runAsyncCode()
}

/*:
 
 ### @MainActor
 
 The SwiftUI update life cycle happens on the main run loop so that events are guaranteed to happen in order. We can use @MainActor with our view models to ensure more robust checking that your object updates in ways that works well with your views. You will typically use @MainActor when using networking code in a view model.
 
    @MainActor
    class ViewModel: ObservableObject {
        @Published var shoppingList: [String] = []
 
        func fetchShoppingList() async {
            //networking code goes here
        }
    }
 
 
 */
