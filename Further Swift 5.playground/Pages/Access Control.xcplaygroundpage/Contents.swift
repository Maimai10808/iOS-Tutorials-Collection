//: [Previous](@previous)
/*:
 ## Access Control
 Access control defines how accessible our code is to code in the same or other modules or source files. Here are some important terms before we begin:
 
 * **Module** a single unit of code distribution.
 * **Source File** a single file where you add your code.
 
 ### Open
 This is the least restrictive access control. It allows a property or method to be accessible from any source file in the defining module or a source file that is in a different module. Open access is the only control that allows code in a different module to subclass classes and override methods from the defining module.
 
 ### Public
 Public is the same as open access except you can only subclass classes and override methods in the defining module.
 
 ### Internal
 Internal is the default access control given to properties or methods that do not explicity have an access control. Internal properties and methods are only accessible to the defining module and can be used from any source file in the defining module.
 
 ### File Private
 File private limits access to properties and methods to the same source file.
 
 ### Private
 Private is the most restrictive access control. It limits access to proerties and methods to the enclosing declaration.
 
*/



//: [Next](@next)
