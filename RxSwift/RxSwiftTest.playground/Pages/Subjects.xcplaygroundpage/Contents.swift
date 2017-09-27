//: [Previous](@previous)

import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { string in
        print(string)
    })
    
    subject.on(.next("1"))
    subject.onNext("2")
    
    let subscriptionTwo = subject.subscribe { event in
        print("2)", event.element ?? event)
    }
    
    subject.onNext("3") // output One, Two
    
    subscriptionOne.dispose()
    subject.onNext("4") // output Two
    
    subject.onCompleted() // 2), 3) completed
    subject.onNext("5") // not output
    subscriptionTwo.dispose()
    let disposeBag = DisposeBag()
    subject.subscribe {
        print("3)", $0.element ?? $0)
    }
    .addDisposableTo(disposeBag)
    subject.onNext("?")
}

//    --- Example of: PublishSubject ---
// 1
// 2
// 3
// 2) 3
// 2) 4
// 2) completed
// 3) completed

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

example(of: "BehaviorSubjedt") {
    let subject = BehaviorSubject(value: "Initial value")
    let disposeBag = DisposeBag()
    
    subject.subscribe {
        print(label: "1)", event: $0)
    }
    .addDisposableTo(disposeBag)
    
    subject.onNext("X") // output 1) X
    subject.onError(MyError.anError)
    subject.subscribe {
        print(label: "2)", event: $0)
    }
    .addDisposableTo(disposeBag)
}

//    --- Example of: BehaviorSubjedt ---
// 1) Initial value
// 1) X
// 1) anError
// 2) anError

example(of: "ReplaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")

    subject.subscribe {
        print(label: "1)", event: $0)  // 1) 2, 1) 3
    }
    .addDisposableTo(disposeBag)
    
    subject.subscribe {
        print(label: "2)", event: $0) // 2) 2, 2) 3
    }
    .addDisposableTo(disposeBag)
    
    subject.onNext("4") // 1) 4, 2) 4
    subject.subscribe {
        print(label: "3)", event: $0) // 3) 3, 3) 4
    }
    .addDisposableTo(disposeBag)

    subject.onError(MyError.anError)
    subject.dispose()
}


// Variable wraps a BehaviorSubject and stores its current value as state
// access current value, value property
// There is no way to add an .error or .completed event onto a variable.
example(of: "Variable") {
    var variable = Variable("Initial value")
    let disposeBag = DisposeBag()
    variable.asObservable().subscribe {
        print(label: "1)", event: $0)
    }
    .addDisposableTo(disposeBag)
    
    variable.value = "1"
    variable.asObservable().subscribe {
        print(label: "2)", event: $0) // 2) 1
    }
    .addDisposableTo(disposeBag)
    
    variable.value = "2"
    
    // this code is won't work
//    variable.value.onError(MyError.anError)
//    variable.asObservable().onError(MyError.anError)s
//    variable.asObservable().onCompleted()
}


//: [Next](@next)
