//: [Previous](@previous)
/*:
 ## Protocol Oriented Programming
 Protocol Oriented Programming (POP) is a programming concept where composition is favored ahead of inheritance (also known as the composite reuse principle). OOP suffers from many problems:
 
 1. **Inhertiance** is only possible with classes but not structs. Therefore, OOP is limited to reference semantics.
 2. **Multiple inheritance** is not possible with Swift which potentially leads to complicated class hierarchies and large monolithic classes.
 3. **Code reusability** is limited with OOP because the parent classes are forced to take on a lot of responsibilities and the child classes only make minimal modifications.
 
 POP overcomes these problems in many ways. It is possible for a structure to conform to a protocol which means that value semantics are supported with POP. A class or structure can conform to multiple protocols therefore making multiple inheritance possible. Protocol extensions make it possible to define default behaviour to conforming types which cuts code redundancy.
 
 Apple has described Swift as a Protocol Oriented language. This means protocols are preferred ahead of classes. In Apple's own words:
 
 "Don't start with a class, start with a protocol."
 
*/


//: [Next](@next)



