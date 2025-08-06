import UIKit







/*
 
 1. This is a version of URLSession that allows us to make a request and receive the response as a completion handler
 2. We get the JSON by serailizing the data and casting it to [String: Any]
 
 
 */







Task {
    
    await fetchRates()
    
}


//print("1")
//
//URLSession.shared.dataTask(with: urlRequest) { data, _, error in
//    
//    print("2")
//    
//    if let error = error {
//        print(error.localizedDescription)
//        return
//    }
//    
//    guard let data = data else {
//        return
//    }
//    
//    do {
//        
//        guard  let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//            return
//        }
//        
//        print("------SUCCESS-------")
//        
//    } catch {
//        
//        print(error.localizedDescription)
//        
//    }
//    
//}
//.resume()
//
//
//print("3")


