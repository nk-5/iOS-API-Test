//: Playground - noun: a place where people can play

import UIKit
import Foundation


class A : NSObject {
    
func testRunLoop() {
    let thread = Thread.init(target: self, selector: Selector("countDown"), object: nil)
    thread.start()
    self.perform(Selector("hello"), on: thread, with: nil, waitUntilDone: true)
}

func countDown() {
    var i = 3
    while i > 0 {
        print(i)
        Thread.sleep(forTimeInterval: 1)
        i = i - 1
    }
    
    // 1秒間だけ、外部からのメソッド実行要求を受け付ける
    // RunLoopがないとtestRunLoopで作成したThreadは破棄され、実行されない
    RunLoop.current.run(mode: .defaultRunLoopMode, before: Date.init(timeIntervalSinceNow: 1))
}
    
    func hello() {
        print("hello")
    }
    
}

let a = A()
a.testRunLoop()