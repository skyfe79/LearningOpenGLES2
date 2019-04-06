//
//  Identity.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

public struct Identity<A> {
  public let a: A
  
}

public struct IdentityTypeConstructor {
  fileprivate let a: Any
  init<A>(_ a: A) { self.a = a}
}

extension Identity: HKTConstructor {
  public typealias HKTValueKeeper = IdentityTypeConstructor

  public static func putIntoBinder(with value: Identity<A>) -> HKT_TypeParameter_Binder<HKTValueKeeper, A> {
    return HKT_TypeParameter_Binder<HKTValueKeeper, A>(valueKeeper: HKTValueKeeper(value))
  }
  
  public static func extractValue(from typeApplication: HKT_TypeParameter_Binder<HKTValueKeeper, A>) -> Identity {
    return typeApplication.valueKeeper.a as! Identity<A>
  }
}

extension Identity: Functor {
  public static func fmap<B>(f: (A) -> B, fa: HKT_TypeParameter_Binder<HKTValueKeeper, A>) -> HKT_TypeParameter_Binder<HKTValueKeeper, B> {
    return Identity<B>(a: f(Identity<A>.extractValue(from: fa).a)).typeBinder
  }
}

extension Identity: Applicative {
  
  public static func pure(a: A) -> HKT_TypeParameter_Binder<HKTValueKeeper, A> {
    return Identity<A>(a: a).typeBinder
  }
  
  public static func apply<B>(f: HKT_TypeParameter_Binder<HKTValueKeeper, (A) -> B>, fa: HKT_TypeParameter_Binder<HKTValueKeeper, A>)
    -> HKT_TypeParameter_Binder<HKTValueKeeper, B> {
      let f_ = Identity<(A) -> B>.extractValue(from: f)
      let fa_ = Identity<A>.extractValue(from: fa)
      let fb_ = f_.a(fa_.a)
      return Identity<B>(a:fb_).typeBinder
      
  }
}

extension Identity: Monad {
  public static func bind<B>
    (ma: HKT_TypeParameter_Binder<HKTValueKeeper, A>, f: (A) -> HKT_TypeParameter_Binder<HKTValueKeeper, B>)
    -> HKT_TypeParameter_Binder<HKTValueKeeper, B> {
      return f(Identity<A>.extractValue(from: ma).a)
  }
}
