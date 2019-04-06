//
//  HaskellStyle.swift
//  ParsecMock
//
//  Created by Keith on 2018/7/4.
//  Copyright © 2018 Keith. All rights reserved.
//
import PaversFRP
public struct haskellStyle<U> {
  public let languageDef
    = LanguageDef<U>(commentStart: "{-",
                     commentEnd: "-}",
                     commentLine: "--",
                     nestedComments: true,
                     identStart: letter(),
                     identLetter: alphaNum() <|> oneOf("-'".chars),
                     opStart: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     opLetter: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     reservedNames: [],
                     reservedOpNames: [],
                     caseSensitive: true)
}

public struct javaStyle<U> {
  public let languageDef
    = LanguageDef<U>(commentStart: "/*",
                     commentEnd: "*/",
                     commentLine: "//",
                     nestedComments: true,
                     identStart: letter(),
                     identLetter: alphaNum() <|> oneOf("-'".chars),
                     opStart: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     opLetter: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     reservedNames: [],
                     reservedOpNames: [],
                     caseSensitive: true)
}


public struct emptyDef<U> {
  public let languageDef
    = LanguageDef<U>(commentStart: "",
                     commentEnd: "",
                     commentLine: "",
                     nestedComments: true,
                     identStart: letter() <|> char("_"),
                     identLetter: alphaNum() <|> oneOf("-'".chars),
                     opStart: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     opLetter: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     reservedNames: [],
                     reservedOpNames: [],
                     caseSensitive: true)
}

public struct haskell98Def<U> {
  public let languageDef
    = LanguageDef<U>(commentStart: "",
                     commentEnd: "",
                     commentLine: "",
                     nestedComments: true,
                     identStart: letter() <|> char("_"),
                     identLetter: alphaNum() <|> oneOf("-'".chars),
                     opStart: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     opLetter: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     reservedNames: ["::","..","=","\\","|","<-","->","@","~","=>"],
                     reservedOpNames: ["let","in","case","of","if","then","else",
                                       "data","type",
                                       "class","default","deriving","do","import",
                                       "infix","infixl","infixr","instance","module",
                                       "newtype","where",
                                       "primitive"],
                     caseSensitive: true)
}

public struct haskellDef<U> {
  public let languageDef
    = LanguageDef<U>(commentStart: "",
                     commentEnd: "",
                     commentLine: "",
                     nestedComments: true,
                     identStart: letter() <|> char("_"),
                     identLetter: alphaNum() <|> oneOf("-'".chars) <|> char("#"),
                     opStart: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     opLetter: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     reservedNames: ["::","..","=","\\","|","<-","->","@","~","=>"] + ["foreign","import","export","primitive","_ccall_","_casm_","forall"],
                     reservedOpNames: ["let","in","case","of","if","then","else",
                                       "data","type",
                                       "class","default","deriving","do","import",
                                       "infix","infixl","infixr","instance","module",
                                       "newtype","where",
                                       "primitive"],
                     caseSensitive: true)
}

public func haskell<U>() -> TokenParser<U> {
  return makeTokenParser(haskellDef<U>().languageDef)
}


public struct mondrianDef<U> {
  public let languageDef
    = LanguageDef<U>(commentStart: "/*",
                     commentEnd: "*/",
                     commentLine: "//",
                     nestedComments: true,
                     identStart: letter(),
                     identLetter: alphaNum() <|> oneOf("-'".chars),
                     opStart: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     opLetter: oneOf(":!#$%&*+./<=>?@\\^|-~".chars),
                     reservedNames: [ "case", "class", "default", "extends"
                      , "import", "in", "let", "new", "of", "package"],
                     reservedOpNames: [],
                     caseSensitive: true)
}

public func mondrian<U>() -> TokenParser<U> {
  return makeTokenParser(mondrianDef<U>().languageDef)
}
