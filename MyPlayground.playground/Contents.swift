//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let constantNum: Int = 10
let constantString: String = "Hello, MDB!"

var variableNumber: Int  = 10
variableNumber = 20
variableNumber+=5

var x = 5 // no type declaration
var name = "someone", twitterfollowers = 0
var bla = "bla"; let abla = "blbalsjdla"

var margin: CGFloat = 30

var n1 = 10, n2 = 6
n1*n2
n1/n2
n1 % n2

var 😭 = "cry"
var s1 = "Hello", s2 = "MDB"
s1 + s2
var fullString = "\(s1), \(s2)"


var emptyString1 = ""
var emptyString2 = String()
s1 += "Hi"

Double(n1)/Double(n2)
Int("5")

var list: [String] = [] //array creation, array of Strings
var longList = Array<String>()
var explicitList = ["this", "is", "a", "list"]

list.append("1")
list.append("2")
list.count
list.insert("0", atIndex:0)
list.first
list = []

var genericList: [AnyObject] = []
genericList.append(0 as AnyObject)
genericList.append("string" as AnyObject)

//let defaultArray = Array(repeating: "1", count: 10)
//defaultArray.isEmpty
//let totalArray = defaultArray + list

var dict: [String: String] = [:]
dict["v"] = "iOS"
dict["aneesh"] = "android"
//can't have same two keys --> will override 

var set = Set<String>()
set.insert("A")
set.insert("B")
var inferredTypeSet: Set = ["this", "is", "a", "set"]
//
//set.union(inferredTypeSet)
//set.intersection(inferredTypeSet)

for i in 0...5{
}

for j in 0..<5 {
    
}

for _ in 0...5 {
}
for value in list {
    print(value)
}

for (key, val) in dict {
    print("Key: \(key), Value: \(val)")
}
var i = 0
while i < 10 {
    i+=1
}

//repeat {
//    j += 1
//} while j <0


/* if condition {
 statement()
 } else if condition2 {
    statement2() 
 } else {
    statement3
 }
*/

var setState = set.isEmpty ? "empty" : "not empty"

//switch dict["Virindh"]! {
//    case "Android":
//        print("lame")
//        fallthrough
//    case "iOS":
//        print("yayy")
//default:
//    print("default")
//}

for i in 0...5 {
    if i == 1{
        continue
    } else if i == 4{
        break
    }
    print(i)
}

// optional keyword: override, required, convenience, public/private, static
// "func" keyword
// function name 
// parameters - reference and type
// return type
func function() {
}
func function1(param1: String) {
    print(param1)
}
func function2(param1: String, param2: Int){}

func function2() -> String {
    return "hello"
}

func getTuple() -> (val1: Int, val2: Int) {
    return (0,1)
}

let tuple = getTuple()
tuple.val1
tuple.val2
func function5(argumentLable param1: String, argumentLabel2 param2: String) -> String {
    return param1 + param2
}
//let str = function5(argumentLable: "hello", argumentLabel2: "mdb")

let strVal = "1"
let intVal = Int(strVal)

if let unwrappedVal = Int(strVal){
    print(unwarappedVal)
}

let forceUnwrappedVal = Int(StrVal)!
forceUnwrappedVal

var optionalName: String?
var forcedName: String!






