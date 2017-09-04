//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let a = BlockOperation.init(block: {
    for i in 0..<5 {
        print("\(i)")
    }
})

let b = BlockOperation.init(block: {print("testB")})
let c = BlockOperation.init(block: {print("testC")})

a.addDependency(b)

let queue:OperationQueue = OperationQueue.init()
queue.maxConcurrentOperationCount = 2
queue.addOperation(a)
queue.addOperation(b)
queue.addOperation(c)

// output
//testC
//testB
//0
//1
//2
//3
//4
