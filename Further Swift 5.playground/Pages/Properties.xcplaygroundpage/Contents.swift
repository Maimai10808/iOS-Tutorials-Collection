//: [Previous](@previous)
/*:
 ## Properties
 
 ### Stored Properties
 These are the typical variables and constants of a class or structure.They are referred to as stored properties because they are store a value. Stored properties can utilise observors to respond to changes in the property's value. We use:
 **willSet** to respond to a new value before it is set.
 **didSet** to respond to a new value after it has been set.
 
 ### Lazy Properties
 A lazy property is a stored property whose value is not calculated until the first time it is used. This is useful when:
 * the intial value depends on some other factors.
 * the initialization is computationally expensive.
 
 ### Property Observors
 Property observors respond to changes in the properties values.
 * `willSet` is called just before the value is stored
 * `didSet` is called after the new value is stored
 
 ### Computed Properties
 Computed properties 'compute' their values. They define at minimum a getter to retrieve their value and an optional setter to retrieve and set other properties indirectly. Computed properties do not store any values.
 
 ### Type Properties
Type properties define values that belong to the type itself and not to any instance. This means a typed property defines a value universal to all instances of a particular type.
 
*/

//: [Next](@next)
