/*:
 # Nib
 
 A nib is an archive of data objects that are unarchived at run-time. They include visual objects such as labels and buttons but they also include non-visual objects which are typically the objects that manage the visual objects such as controllers.
 */

/*:
  ![monitor](monitor.png)
*/
/*:
 ## Nib Loading Process
 
 1. The contents of the nib are loaded into memory as an object-graph but not unarchived.
 2. The contents are unarchived and each object is initialized depending on the type of object. Object that conform to NSCoding which includes all subclasses of UIView and UIViewController are initialized with `initWithCoder:`. All other objects are initialized with `init`.
 3. All connections (outlets and actions) are established.
 4. An `awakeFromNib` message is sent to all interface objects except File Owner objects.

*/
/*:
 
 ## File Owner
 The file owner is the link between your application code and the contents of your nib. This will typically be your UIView class code or UIViewController class code with which you add connections to (outlet and actions).
   
 ## First Responder
 The first object in the responder chain that can handle app events. This is typically objects that handle keyboard input like textfields. When a user focuses on a textfield for example, it becomes the first responder.
 
 ## Top Level Objects
 The subset of objects in a nib that do not have a parent object. These are usually just stand-alone views we add into the nib and you can have more than one.

 */
