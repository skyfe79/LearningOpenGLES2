// MARK: Function Precedence Group
precedencegroup LeftApplyPrecedence {
  associativity: left
  higherThan: AssignmentPrecedence
  lowerThan: TernaryPrecedence
}

precedencegroup FunctionCompositionPrecedence {
  associativity: right
  higherThan: LeftApplyPrecedence
}

// MARK: Lens Precedence Group

precedencegroup LensSetPrecedence {
  associativity: left
  higherThan: FunctionCompositionPrecedence
}


// MARK: Monad Precedence Group
precedencegroup RunesMonadicPrecedenceRight {
  associativity: right
  lowerThan: LogicalDisjunctionPrecedence
  higherThan: AssignmentPrecedence
}

precedencegroup RunesMonadicPrecedenceLeft {
  associativity: left
  lowerThan: LogicalDisjunctionPrecedence
  higherThan: AssignmentPrecedence
}

// MARK: Alternative Precedence Group
precedencegroup RunesAlternativePrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
  lowerThan: ComparisonPrecedence
}

// MARK: Applicative Precedence Group

precedencegroup RunesApplicativePrecedence {
  associativity: left
  higherThan: RunesAlternativePrecedence
  lowerThan: NilCoalescingPrecedence
}

precedencegroup RunesApplicativeSequencePrecedence {
  associativity: left
  higherThan: RunesApplicativePrecedence
  lowerThan: NilCoalescingPrecedence
}

// MARK: -


// MARK: Functor Operators
/**
  map a function over a value with context

  Expected function type: `(a -> b) -> f a -> f b`
  Haskell `infixl 4`
*/
infix operator <^> : RunesApplicativePrecedence






// MARK: Applicative Functor Operators
/**
  apply a function with context to a value with context

  Expected function type: `f (a -> b) -> f a -> f b`
  Haskell `infixl 4`
*/
infix operator <*> : RunesApplicativePrecedence

/**
  sequence actions, discarding right (value of the second argument)

  Expected function type: `f a -> f b -> f a`
  Haskell `infixl 4`
*/
infix operator <* : RunesApplicativeSequencePrecedence

/**
  sequence actions, discarding left (value of the first argument)

  Expected function type: `f a -> f b -> f b`
  Haskell `infixl 4`
*/
infix operator *> : RunesApplicativeSequencePrecedence




// MARK: Alternative Operators
/**
  an associative binary operation

  Expected function type: `f a -> f a -> f a`
  Haskell `infixl 3`
*/
infix operator <|> : RunesAlternativePrecedence






// MARK: Monad Functor Operators
/**
  map a function over a value with context and flatten the result

  Expected function type: `m a -> (a -> m b) -> m b`
  Haskell `infixl 1`
*/
infix operator >>- : RunesMonadicPrecedenceLeft

/**
  map a function over a value with context and flatten the result

  Expected function type: `(a -> m b) -> m a -> m b`
  Haskell `infixr 1`
*/
infix operator -<< : RunesMonadicPrecedenceRight



// MARK: Function Operators

/// Pipe forward function application, i.e. `x |> f := f(x)`
infix operator |> : LeftApplyPrecedence

/// Infix, flipped version of fmap (for arrays), i.e. `xs ||> f := f <^> xs`
infix operator ||> : LeftApplyPrecedence

/// Infix, flipped version of fmap (for optionals), i.e. `x ?|> f := f <^> x`
infix operator ?|> : LeftApplyPrecedence


/// Swap binary arguments of a function,
/// i.e. `~f: (A, B)-> C := f': (B,A) -> C`
prefix operator ~




// MARK: Composition Operators

/// Compose forward operator, i.e. `f >>> g := g(f(x))`, called `then`
infix operator >>> : FunctionCompositionPrecedence

/// Compose backward operator, i.e. `f <<< g := f(g(x))`, called `after`
infix operator <<< : FunctionCompositionPrecedence

/// pre-composition, i.e `>>> f`
prefix operator >>>

/// post-composition, i.e `f >>>`
postfix operator >>>



// MARK: Lens Operators

/// Lens view
infix operator ^* : LeftApplyPrecedence

/// Lens set
infix operator .~ : LensSetPrecedence

/// Lens over
infix operator %~ : LensSetPrecedence

/// Lens over with both part and whole.
infix operator %~~ : LensSetPrecedence

/// Lens semigroup
infix operator <>~ : LensSetPrecedence



/// Cons of an element with a non-empty collection.
infix operator +|: AdditionPrecedence

