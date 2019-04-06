//
//  HKT+Array.swift
//  ParsecMock
//
//  Created by Keith on 2018/6/28.
//  Copyright © 2018 Keith. All rights reserved.
//

public struct ArrayValueKeeper {
  public let value: Any
  init<T>(_ array: [T]) { self.value = array}
}



extension Array: HKTConstructor {
  
  public typealias HKTValueKeeper = ArrayValueKeeper
  
  public static func putIntoBinder(with value: Array<Element>) -> HKT_TypeParameter_Binder<HKTValueKeeper, Element> {
    return HKT_TypeParameter_Binder<HKTValueKeeper, Element>(valueKeeper: HKTValueKeeper(value))
  }
  
  public static func extractValue(from typeBinder: HKT_TypeParameter_Binder<HKTValueKeeper, Element>) -> Array {
    return typeBinder.valueKeeper.value as! Array<Element>
  }
}

extension Array: Functor {
  public static func fmap<B>(f: (Element) -> B, fa: HKT_TypeParameter_Binder<HKTValueKeeper, Element>) -> HKT_TypeParameter_Binder<HKTValueKeeper, B> {
    return extractValue(from:fa).map(f).typeBinder
  }
}

extension Array: Applicative {
  public static func pure(a: Element) -> HKT_TypeParameter_Binder<HKTValueKeeper, Element> {
    return [a].typeBinder
  }
  
  public static func apply<B>(f: HKT_TypeParameter_Binder<ArrayValueKeeper, (Element) -> B>, fa: HKT_TypeParameter_Binder<ArrayValueKeeper, Element>)
    -> HKT_TypeParameter_Binder<ArrayValueKeeper, B> {
      let fs = Array<(Element) -> B>.extractValue(from: f)
      let fas = Array<Element>.extractValue(from: fa)
      let fbs = fs.flatMap{ fas.map($0) }
      return fbs.typeBinder
  }
}

extension Array: Monad {
  public static func bind<B>
    (ma: HKT_TypeParameter_Binder<ArrayValueKeeper, Element>, f: (Element) -> HKT_TypeParameter_Binder<ArrayValueKeeper, B>)
    -> HKT_TypeParameter_Binder<ArrayValueKeeper, B> {
      return extractValue(from: ma).map(f).flatMap{Array<B>.extractValue(from: $0)}.typeBinder
  }
}
