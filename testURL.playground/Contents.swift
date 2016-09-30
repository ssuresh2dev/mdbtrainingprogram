//: Playground - noun: a place where people can play

import UIKit

extension String{
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
        }
    }
}

"3".isNumber
"haoisjdoiasjd".isNumber

