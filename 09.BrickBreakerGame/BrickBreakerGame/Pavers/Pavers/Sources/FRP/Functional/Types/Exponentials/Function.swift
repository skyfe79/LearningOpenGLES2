/**
 Swap two arguments of a function f, i.e. f:(A,B)->C ~ f:(B, A)->C

 - parameter f: A function from (A,B) -> C

 - returns: A function from (B,A)->C.
 */
public prefix func ~ <A,B,C> (_ f: @escaping (A, B) -> C)
  -> (B, A) -> C {
  return { f($1, $0) }
}


/**
 Pipe a value into a function.

 - parameter x: A value.
 - parameter f: A function

 - returns: The value from apply `f` to `x`.
 */
public func |> <A, B> (x: A, f: (A) -> B) -> B {
  return f(x)
}

public func backwardPipe<A, B>() -> (@escaping (A) -> B, A) -> B {
  return ~(|>)
}

/**
 Pipe a collection of values into a function, i.e. a flipped-infix operator for `map`.

 - parameter xs: An array of values.
 - parameter f:  A transformation.

 - returns: An array of transformed values.
 */
public func ||> <A, B> (xs: [A], f: (A) -> B) -> [B] {
  return xs.map(f)
}

/**
 Pipe an optional value into a function, i.e. a flipped-infix operator for `map`.

 - parameter x: An optional value.
 - parameter f: A transformation.

 - returns: An optional transformed value.
 */
public func ?|> <A, B> (x: A?, f: (A) -> B) -> B? {
  return x.map(f)
}

/**
 Composes two functions in left-to-right order, i.e. (f >>> g)(x) = g(f(x))
 
 read as "f then g"
 
 - parameter g: A function.
 - parameter f: A function.
 - returns: A function that is the composition of `f` and `g`.
 */
public func >>> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
  return { g(f($0)) }
}

/**
 Composes two functions in right-to-left order, i.e. (f <<< g)(x) = f(g(x))
 
 read as "f after g"

 - parameter g: A function.
 - parameter f: A function.
 - returns: A function that is the composition of `f` and `g`.
 */
public func <<< <A, B, C> (f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
  return { f(g($0)) }
}

/**
 (2+)
 section(2, +) :: A -> A
 */
public func sec<A, B, C>(_ a: A, _ f: @escaping (A, B) -> C) -> (B) -> C {
  return sec(a, curry(f))
}

/**
 (+2)
 section(+, 2) :: A -> A
 */
public func sec<A, B, C>(_ a: A, _ f: @escaping (A) -> (B) -> C) -> (B) -> C {
  return f(a)
}


/**
 (+2)
 section(+, 2) :: A -> A
 */
public func sec<A, B, C>(_ f: @escaping (A, B) -> C, _ b: B) -> (A) -> C {
  return sec(curry(f), b)
}

/**
 (+2)
 section(+, 2) :: A -> A
 */
public func sec<A, B, C>(_ f: @escaping (A) -> (B) -> C, _ b: B) -> (A) -> C {
  return { a in f(a)(b) }
}

/**
 The identity function on `A`.
 See identity morphism as a mapping from object A to object A.

 - parameter x: Any value.

 - returns: `x`
 */
public func id <A> (_ x: A) -> A {
  return x
}

//public func identity <A> (_ x: A) -> A {
//  return x
//}

public func terminal<A>(_ x: A) -> () {
  return ()
}

/**
 The identity morphism on `A`.
 See identity morphism as a mapping from object to arrow.
 
 - type parameter A: Any Type

 - returns: f : A -> A
 */
public func identityMorphism <A> () -> (A) -> A {
  return id
}



/**
 A constant function.

 - parameter b: A value.

 - returns: A function that returns `b` no matter what it is fed.
 */
public func const <A, B> (_ b: B) -> ((A) -> B) {
  return { _ in b }
}

/**
 A global element function meaning x belongs to X.
 For all f, g : A -> B, if for all x: 1 -> A, x >>> f == x >>> g, then f == g.
 That is a category is well-pointed.

 - parameter x: A value of X.

 - returns: A function that returns `x` no matter what it is fed.
 */
public func globalElement <X> (of x: X) -> (Unit) -> X {
  return { _ in x }
}

/**
 A generalized element function. Slice Category C/X.

 - parameter f: A function whose domian is X.

 - returns: A function that returns `x` no matter what it is fed.
 */
public func generalizedElement <A, X> (of f: @escaping (A) -> X) -> (A) -> X {
  return f
}


/**
 The absurb function.

 - parameter f: A function whose domian is X.

 - returns: A function that returns `x` no matter what it is fed.
 */
public func absurb<A>(e: Empty) -> A {
  fatalError("The absurb function cannot be called with argument of Empty")
}


/**
 A function that returns unit no matter takes what parameter.
 
 - parameter x: any element of any type
 
 - returns: unit.
 */
public func unit<X>(_ x: X) -> () { return () }

public func falseness<X>(_ x: X) -> Bool { return false }

public func trueness<X>(_ x: X) -> Bool { return true }









