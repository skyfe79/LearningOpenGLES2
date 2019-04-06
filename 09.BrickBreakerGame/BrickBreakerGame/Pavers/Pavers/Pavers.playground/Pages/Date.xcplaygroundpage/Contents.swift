//: [Previous](@previous)

import Foundation
import PaversFRP

let date = Date().addingTimeInterval(Double(-1).day * 3)

date.to(.yyyy_mm_dd_h24_mi_ss)
date.to(.yyyymmddh24miss)
date.to(.yyyy_mm_dd_h24_mi_ss_ms)

let x = "20171231000000".to(.yyyymmddh24miss)
x?.to(.yyyymmddh24miss)

//: [Next](@next)
