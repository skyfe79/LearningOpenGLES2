import Foundation

/**
 Associates a key/object pair to a host object. Usage:

 ```
 var key: UInt8 = 1
 let label = UILabel()
 lazyAssociatedProperty(label, &key, { 1 })
 ```

 - parameters:
 - host: The object that will have the associated object.
 - key: A pointer for identifying the associated object being stored in the host.
 - factory: A function that returns the object to be assoicated to the host.

 - returns: If an object is already associated to the host with the give key that object will be returned.
 Otherwise the `factory` closure is invoked and that value is returned.
 */
internal func lazyAssociatedProperty <T: AnyObject> (_ host: AnyObject, key: UnsafeRawPointer,
                                                     factory: () -> T) -> T {

  if let value = objc_getAssociatedObject(host, key) as? T {
    return value
  }

  let value = factory()
  objc_setAssociatedObject(host, key, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  return value
}
