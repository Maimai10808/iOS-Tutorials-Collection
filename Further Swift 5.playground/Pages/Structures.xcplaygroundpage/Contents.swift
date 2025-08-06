//: [Previous](@previous)
/*:
 ## Structures
 Structures are **value** types. This means that a copy of its value is assigned every time it is passed to variable, constant or function.
 
 All the basic or primitive types in Swift are structures. This includes Integers, Doubles, Floats and Strings.
 
 We create an instance of a structure through a process known as *initialization*. Initialization can only succeed if all the properties of a structure are setup with initial values before the structure is used for the first time. We do this by:
 1. Assigning default values to all the properties of the structure.
 2. By passing intial values to properties without default values through custom initialization.
 3. Through memberwise initialization which is what automatically exists if no custom initializer is set.
 
 The mutability of an instance of a structure depends on whether it is passed to a variable or constant. If you pass a structure to a constant all of its properties become immutable even if the property was declared as a variable.
 
 `self` is immutable in a structure's methods. This means properties are cannot be mutated inside a structure's methods. In order to mutate a property from inside a method we need to mark the method `mutating`.
*/



//: [Next](@next)
