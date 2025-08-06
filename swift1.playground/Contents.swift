import UIKit


func printName(name:String) {
    print(name)
}

printName(name:"mai")
printName(name:"yu")
printName(name:"fan")


func add(onenum: Int, to twonum: Int) -> Int {
    let sum = onenum + twonum
    print(sum)  // Print the sum
    return sum  // Return the sum
}

add(onenum: 1, to: 2)


let foods = ["apple","banana","peer","paper"]

for food in foods {
    print(food)
}


enum famliy {
    case me
    case sister
    case brother
    case father
    case mother
    
}

func celebretefamliy(on family:famliy){
    if family == .me {
        print("yes,it is me!!!")
    }else if family == .sister {
        print("yes,it is sister!!!")
    }else if family == .brother {
        print("yes,it is brother!!!")
    }else if family == .father {
        print("yes,it is father!!!")
    }else if family == .mother {
        print("yes,it is mother!!!")
    }
}

celebretefamliy(on: .sister)













