////
////  JSONParser.swift
////  PaversParsec2
////
////  Created by Keith on 2018/6/26.
////  Copyright © 2018 Keith. All rights reserved.
////
//
import PaversFRP

public enum JSON {
  
  internal static let whitespace: ParserS<Character> = satisfy(CharacterSet.whitespacesAndNewlines.contains) <?> "whitespace"
  internal static let whitespaces = many(whitespace) <?> "whitespaces"
  
  
  
  /// Null Type
  public static let null: ParserS<()> = string("null").fmap(terminal) <?> "null"
  
  
  
  /// Bool Type
  internal static let bTrue: ParserS<String> = string("true") <?> "true"
  internal static let bFalse: ParserS<String> = string("false") <?> "false"
  public static let bool: ParserS<Bool> = (bTrue <|> bFalse).fmap{ $0 == "true" ? true : false } <?> "bool"
  
  
  
  /// Number Type
  internal static let digit: ParserS<Character> = satisfy(CharacterSet.decimalDigits.contains) <?> "digit"
  internal static let digits = many1(digit) <?> "digits"
  internal static let dicimalPoint: ParserS<Character> = char(".") <?> "dicimal point"
  internal static let plusSign: ParserS<Character> = char("+") <?> "plus sign"
  internal static let minusSign: ParserS<Character> = char("-") <?> "minus sign"
  internal static let plusOrMinus = plusSign <|> minusSign <?> "sign"
  internal static let decimalFactionPart = (dicimalPoint >>- digits) <?> "decimalFactionPart"
  public static let number =
    (plusOrMinus.? >>> digits >>> decimalFactionPart.?)
      .fmap { (sign, decimalString, fractionString) -> Double in
        let sign_ = sign ?? "+"
        let fractionPart = fractionString ?? []
        let fraction_ = String(fractionPart)
        let decimals = String(decimalString)
        let numberStr = "\(sign_)\(decimals).\(fraction_)"
        return Double(numberStr)!
  } <?> "number"
  
  
  
  
  /// String Type
  internal static let letter: ParserS<Character> = satisfy{$0 != "\""}  <?> "letter"
  internal static let letters = many1(letter)  <?> "letters"
  internal static let doubleQuoate: ParserS<Character> = char("\"")  <?> "double quoate"
  public static let jstring = (doubleQuoate >>> letters.? >>> doubleQuoate)
    .fmap { (_, str, _) -> String in
      return String.init(str ?? [])
  }  <?> "jstring"
  
  
  
  
  
  /// Array Type
  internal static let squareBracketFront: ParserS<Character> = char("[")  <?> "squareBracketFront"
  internal static let squareBracketBack: ParserS<Character> = char("]") <?> "squareBracketBack"
  
  internal static let item: () -> ParserS<Any> =
    (try_(anize(null))
      <|> try_(anize(number))
      <|> try_(anize(jstring))
      <|> try_(anize(bool))
      <|> try_(anize({array}))
      <|> try_(anize({object}))
      ) <?> "item"
  
  
  internal static let comma: ParserS<Character> = char(",")  <?> "comma"
  internal static let commaItem = fmap(comma >>> whitespaces >>> item){(_, _, item) in item}
  internal static let itemCommaList: () -> ParserS<[Any]> =
    fmap(item >>> whitespaces >>> many(commaItem)){ (first, _, rest) -> [Any] in return [first] + rest}  <?> "itemCommaList"
  
  public static let array: () -> ParserS<[Any]> =
    fmap(squareBracketFront >>> whitespaces >>> itemCommaList.? >>> whitespaces >>> squareBracketBack) {
      (_, _, items, _, _) -> [Any] in
      return items ?? [] } <?> "array"
  
  
  internal static func anize<A> (_ a : @autoclosure () -> ParserS<A>) -> ParserS<Any> {
    return a().fmap{ (x) -> Any in return x }
  }
  
  internal static func anize<A> (_ a : @escaping () -> ParserS<A>) -> () -> ParserS<Any> {
    return {a().fmap{ (x) -> Any in return x }}
  }
  
  internal static func anize<A> (_ a : @escaping () -> () -> ParserS<A>) -> () -> ParserS<Any> {
    return {a()().fmap{ (x) -> Any in return x }}
  }
  
  
  /// Object {"key": value , "key": value ... }
  internal static let bracketFront: ParserS<Character> = char("{") <?> "bracketFront"
  internal static let bracketEnd: ParserS<Character> = char("}") <?> "bracketEnd"
  internal static let key = jstring <?> "key"
  internal static let colon: ParserS<Character> = char(":") <?> "colon"
  internal static let value: () -> ParserS<Any> = item
  
  internal static let keyValuePair: () -> ParserS<(String, Any)> =
    fmap(key >>> whitespaces >>> colon >>> whitespaces >>> value){
      (k, _, _, _, v) -> (String, Any) in (k, v)
  } <?> "key value pair"
  
  internal static let commaKV = fmap(comma >>> whitespaces >>> keyValuePair){(_, _, kv) in kv}
  internal static let kvCommaList: () -> ParserS<Dictionary<String, Any>> =
    fmap(keyValuePair >>> whitespaces >>> many(commaKV)){
      (kv, _, kvs) -> Dictionary<String, Any> in
      return Dictionary.init(uniqueKeysWithValues: [kv]+kvs)
  } <?> "kvCommaList"
  
  public static let object: () -> ParserS<Dictionary<String, Any>> =
    fmap(bracketFront >>> whitespaces >>> kvCommaList.? >>> whitespaces >>> bracketEnd){
      (_, _, kvs, _, _) -> Dictionary<String, Any> in
      return kvs ?? [:]
  } <?> "object"
}
