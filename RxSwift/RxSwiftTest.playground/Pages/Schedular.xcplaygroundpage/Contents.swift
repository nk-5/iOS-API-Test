//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa


// Utils
let start = Date()

fileprivate func getThreadName() -> String {
    if Thread.current.isMainThread {
        return "Main Thread"
    } else if let name = Thread.current.name {
        if name == "" {
            return "Anonymous Thread"
        }
        return name
    } else {
        return "Unknown Thread"
    }
}

fileprivate func secondsElapsed() -> String {
    return String(format: "%02i", Int(Date().timeIntervalSince(start).rounded()))
}

extension ObservableType {
    func dump() -> RxSwift.Observable<Self.E> {
        return self.do(onNext: { element in
            let threadName = getThreadName()
            print("\(secondsElapsed())s | [D] \(element) received on \(threadName)")
        })
    }
    
    func dumpingSubscription() -> Disposable {
        return self.subscribe(onNext: { element in
            let threadName = getThreadName()
            print("\(secondsElapsed())s | [S] \(element) received on \(threadName)")
        })
    }
}

// Schedular learn

let bag = DisposeBag()

let fruit = Observable<String>.create { observer in
    observer.onNext("[apple]")
    sleep(1)
    observer.onNext("[pineapple]")
    sleep(1)
    observer.onNext("[strawberry]")
    return Disposables.create()
}

let globalSchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
let mainSchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.main)

fruit
    .subscribeOn(globalSchedular)
    .subscribeOn(mainSchedular)  // not work. dump is Anonymous thread
    .dump()
    .observeOn(MainScheduler.instance)
    .dumpingSubscription()
    .disposed(by: bag)

let label = UITextField()
label.text = "keigo"

let text = label.rx.text.asDriver(onErrorJustReturn: "error on Driver")

RunLoop.main.run(until: Date(timeIntervalSinceNow: 13))




//: [Next](@next)
