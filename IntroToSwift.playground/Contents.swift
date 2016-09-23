//: Playground - noun: a place where people can play

import UIKit

// Data Types:
let constantNum: Int = 10
let constantString: String = "Hello, MDB!"
let constantDouble: Double = 10.0
let constantFloat: Float = 10.0
let constantBoolean: Bool = true
let constantLong: CLong = 10
let constantChar: Character = "a" // Note that characters and strings both use double quotes, not single!

// These are all declared with the let identifier - what does that mean?
// Lets try changing constantNum to 20; uncomment the line below.
// constantNum = 20
// What went wrong? The 'let' identifier allows you to create constant variables with a fixed value
// If we want to create a variable that we can change, we use the 'var' identifier:
var variableNumber: Int = 10
variableNumber = 20
variableNumber -= 5

// Note that 'let' is more memory efficient, so we should use it whenever possible in place of 'var'

// We can also declare variables on the same line if they all use the same identifier
let name = "Virindh", twitterFollowers = 0, everGoingToChange = false

// Notice that in the above declarations, we didn't specify the type for any of the variables
// We use type annotations to explicitly state the type for a variable, but these are actually unnecessary in Swift
var x = 4.0 // Swift uses type inference to recognize that x is a Double (what if we want a Float?)
// Sometimes we might need to specify a type if it could be inferred as something else, or if we want to declare variables without assigning them:
var topMargin: CGFloat
topMargin = 30

// Even though we don't have to specify the type, we can't reassign variables to different types!
// See what happens when we change x to a String
// x = "4.0"
// This will be the case regardless of whether or not we specify the type explicitly.

// What about naming convention?
// We can name variables using any valid Unicode characters
// The only restrictions: can't start with a number or include any whitespace, mathematical symbols, arrows, etc.
var 😀 = "HAPPY!"

//////////////////////////////////////////////////////////////////////////////////////////////////

// Operations

var n1 = 10, n2 = 6
n1*n2
n1/n2
n1%n2

var s1 = "Hello", s2 = "MDB"
s1 + s2
// Strings also can be interpolated (that is, we can reference existing variables in Strings by using placeholders:
var fullString = "\(s1), \(s2)"
// We can also use built-in String functions
s1.appending(s2)
s1.replacingOccurrences(of: "e", with: "3")
s1.lowercased()
// Note that these functions are not destructive!

// We can create empty strings like so:
var emptyString1 = ""
// OR like so:
var emptyString2 = String()
// If a string is declared with var, it IS mutable (unlike Java)
// We won't go too much into String operations, but check out the documentation for the String class to see some of the other functions it supports!

// We can also convert the type of a primitive variable like so:
Double(n1)/Double(n2)
String(n1)

// Some other operations: Commenting, Printing, etc.
// We write comments using // or using /* */ for multiple lines
// We can print by calling the print() function
print("\(n1) divided by \(n2) is \(Double(n1)/(Double(n2)))")
// Note that when you debug code you can also use functions like NSLog instead of print to write to the console

// Semicolons: we don't need em! But use them for multiple statements on the same line:
var h = 10; let w = 20;
// That being said, don't do multiple statements on the same line!

//////////////////////////////////////////////////////////////////////////////////////////////////

// Advanced Variables: Collection Types

// The main collection types we typically use are arrays and dictionaries, although we can also use things like tuples and sets
var list: [String] = []
var explicitList = ["this", "is", "one", "way", "of", "declaring", "arrays"]

list.append("1")
list.append("2")
list.count
list.insert("0", at: 0)
list.first
// Note that even if we empty the array, we cannot insert elements that are not strings
// However, we can make arrays that store generic Objects using the AnyObject class
// Literally, ANY object belongs to the AnyObject class
var genericList: [AnyObject] = []
genericList.append(0 as AnyObject)
genericList.append("what" as AnyObject)
genericList[0]
genericList[1]

// Some other array functions:
let defaultArray: [String] = Array(repeating: "1", count: 10)
defaultArray.isEmpty
let totalArray = defaultArray + list

// Dictionaries
var dict: [String:String] = [:]
dict["Sameer"] = "iOS"
dict["Aneesh"] = "Android"
dict["Aneesh"] = "iOS"

// Sets
// Sets are unordered lists - we typically use them if we don't care about accessing particular elements, if order doesn't matter, or if we need to store unique values.
var set = Set<String>()
set.insert("A")
set.insert("B")
var inferredTypeSet: Set = ["this", "is", "a", "set"]
// We can perform operations on sets like union and intersection
set.union(inferredTypeSet)
set.intersection(inferredTypeSet)

// So how do we iterate through these?
// Swift offers multiple functions for iteration including for, for-in, while, etc.

// In other languages like Java, we could perform for loops like so:
/*
 for(int i = 0; i < 10; i++) {}
 */
// In Swift 3, we don't use for loops this way, we use for-in loops:
for i in 0...10 {
    print(i)
}
// Or, if we don't care about the actual variable name:
for _ in 0...2 {
    print("lol")
}
// Note that we use ... for inclusive and ..< for exclusive
// To iterate over an array, we can do:
for value in list {
    print(value)
}
// If we have a dictionary, we can iterate through it using a tuple for the key and value:
for (key, val) in dict {
    print("Key: \(key), Val: \(val)")
}

// We can also use while loops:
var i = 0
while i < 10 {
    i += 1
}

// Or, if we want to go through the loop at least once regardless, 
var j = 0
repeat {
    j += 1
} while j < 0

// What about conditionals??
// Conditionals are done using either if statements or switch statements:
// The format for an if statement is much like most languages:
/*
if condition {
    statement
} else if condition2 {
    statement2
} else {
    statement3
}
 Note that parentheses are allowed for conditions but should be avoided unless handling some complex conditional
 */
// For example,
if set.isEmpty {
    print("empty")
} else {
    print("not empty")
}

// We can also make simple if-else statements on one line (these are called ternary conditionals)
var setState = set.isEmpty ? "empty" : "not empty"
print(setState)

// Switch statements are typically used if we're comparing some case-based conditional (we'll see this more later)
// Lets go back to the dictionary -
switch dict["Sameer"]! {
case "Android":
    print("lame")
case "iOS":
    print("thank God")
default: print("default")
}

// Lastly, we can cause early exits/skips within for loops using continue and break:
for i in 0...5 {
    if i == 1 {
        continue // Skip the rest of the statements in the loop but move on to next value of i
    } else if i == 4 {
        break // Exit loop completely
    }
    print(i)
}

// Functions
// We've learned how to execute simple statements but these statements need to belong in some function call for us to be able to execute them when we want to.
// Every function has the following attributes:
// (Optional) keywords: override, required, convenience, public/private, static, etc.
// func keyword
// functionName (no spaces)
// list of parameters (or () if none)
// return type (omit if none)
// Thus, a very simple function may look like:
func function() {}
// We can add parameters by creating a reference and passing its type:
func function2(param1: String) {}
// or multiple like so:
func function3(param1: String, param2: Int) {}
// We can also provide return types like so:
func function4() -> String {return ""}
// Or multiple return types using tuples:
func getTuple() -> (val1: Int, val2: Int) {
    return (1, 2)
}

// Suppose we had the following function:
func function5(param1: String, param2: String) -> String {
    return param1 + param2
}
// We would call this function like so:
let combinedString = function5(param1: "Hello", param2: "MDB") // --> Note that we must provide the labels when we call this function

// It's possible that we may want to specify a particular label for referencing a parameter that makes more sense to the user or encapsulates something about the function itself - we can provide optional argument labels like so:
func function6(argumentLabel1 param1: String, argumentLabel2 param2: String) -> String {
    return param1 + param2
}
let combinedString2 = function6(argumentLabel1: "Hello", argumentLabel2: "MDB")
// Thus, even though we reference the variables as param1 and param2 within the function, we call them argumentLabel1 and argumentLabel2 when we actually CALL the function

// On the other hand, if we don't want the user to have to enter in a label at all, we can use _ as the argument label:
func function7(_ param1: String) {}
function7("Hello")

// Lastly, we can also nest functions:
func function8() {
    func function9() {
        
    }
    function9()
}

// Optionals
// One of the really powerful things about Swift is its ability to handle null values really well. Swift allows us to specify that a particular variable is "optional" (meaning it is possible for it to be nil). 
// We denote optionals using a ?
// When a variable is expressed as optional, we can "unwrap" it to access its value (if it contains one).
// For example, if we have a string and attempt to convert it to an int:
let strVal = "1"
let intVal = Int(strVal)
print(intVal)
// What happened here?? Why did it print Optional(1) instead of just 1?
// As far as the program knows, strVal may or may not actually contain a number - so when we convert it into an int, there's a possibility that the call may fail (in which case intVal is technically nil)
// How do we check if it worked or not? Unwrap! Example:
if let unwrappedVal = Int(strVal) {
    print(unwrappedVal)
}
// "if let" statements are only executed if we were able to assign the variable to a non-nil value. 
// In other words, if Int(strVal) is nil, the rest of the statement will not execute.
// This is called "safely unwrapping" because we throw potentially dangerous statements into an if statement that won't execute if something goes wrong. 

// Suppose, however, we know for a fact that strVal is "1" and that it will definitely ALWAYS return an int successfully - we can use force unwrapping here using the ! symbol:
let forceUnwrappedVal = Int(strVal)!
print(forceUnwrappedVal)
// Force unwrapping can be potentially dangerous if we assume that something will always return a non-null value but it turns out we missed some edge case. However, force unwrapping is useful if you want to avoid nesting statements into a large series of if statements.

// We can also specify whether a variable is optional or not when we declare it:
var optionalName: String?
var forcedName: String!
forcedName = "hello"
// If we declare forcedName with the ! symbol, we guarantee that it will always have a non-null value whenever we reference it. However, by specifying that optionalName is optional, whenever we reference it Xcode will make us unwrap it before we're able to use it. 

// One cool thing we can do with this: guard statements
// When we enter a function we can use guard statements to ensure some value is not nil and exit the function otherwise:
guard let guardedName = forcedName else {
    fatalError()
}























