//
//  HigherKindedType.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

import PaversFRP

/// * -> *
/// tell what the type is in the HKTValueKeeper
public struct HKT_TypeParameter_Binder <HKTValueKeeper, HKTArgumentType> {
  let valueKeeper: HKTValueKeeper
}
public typealias HKT<F, A> = HKT_TypeParameter_Binder <F, A>

/// A protocol all type constructors must conform to.
/// * -> *
public protocol HKTConstructor {
  /// The existential type that erases `Argument`.
  /// This should only be initializable with values of types created by the current constructor.
  associatedtype HKTValueKeeper
  /// The argument that is currently applied to the type constructor in `Self`.
  associatedtype A
  
  var typeBinder: HKT_TypeParameter_Binder<HKTValueKeeper, A> { get }
  
  static func putIntoBinder(with value: Self) -> HKT_TypeParameter_Binder<HKTValueKeeper, A>
  
  static func extractValue(from binder: HKT_TypeParameter_Binder<HKTValueKeeper, A>) -> Self
}

extension HKTConstructor {
  public var typeBinder: HKT_TypeParameter_Binder<HKTValueKeeper, A> {
    return Self.putIntoBinder(with: self)
  }
}


/// fmap :: (a -> b) -> f a -> f b
public protocol Functor: HKTConstructor {
  typealias F = HKTValueKeeper
  static func fmap<B>(f: (A) -> B, fa: HKT<F, A>) -> HKT<F, B>
}


/// pure :: a -> f a
/// apply :: f (a -> b) -> f a -> f b
public protocol Applicative: Functor {
  static func pure(a: A) -> HKT<F, A>
  static func apply<B>(f: HKT<F, (A) -> B>, fa: HKT<F, A>) -> HKT<F, B>
}


/// return :: a -> m a
/// bind :: m a -> (a -> m b) -> m b
public protocol Monad: Applicative {
  typealias M = HKTValueKeeper
  static var `return`: (A) -> HKT<M, A> {get}
  static func bind<B> (ma: HKT<M, A>, f: (A) -> HKT<M, B>) -> HKT<M, B>
}

extension Monad {
  public static var `return`: (A) -> HKT<M, A> {return pure}
}
