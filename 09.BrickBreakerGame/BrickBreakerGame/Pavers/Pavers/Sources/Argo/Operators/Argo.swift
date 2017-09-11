import PaversFRP

precedencegroup ArgoDecodePrecedence {
  associativity: left
  higherThan: RunesApplicativeSequencePrecedence
  lowerThan: NilCoalescingPrecedence
}

infix operator <| : ArgoDecodePrecedence
infix operator <|? : ArgoDecodePrecedence
infix operator <|| : ArgoDecodePrecedence
infix operator <||? : ArgoDecodePrecedence
