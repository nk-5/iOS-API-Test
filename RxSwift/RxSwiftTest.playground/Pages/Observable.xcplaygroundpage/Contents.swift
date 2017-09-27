//: [Previous](@previous)

import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "just, of, from") {
    let one = 1
    let two = 2
    let three = 3
    
    let observable: Observable<Int> = Observable<Int>.just(one)
    let observable2 = Observable.of(one, two, three)
    let observable3 = Observable.of([one, two, three])
    let observable4 = Observable.from([one, two, three])
    // let observable5 = Observable.just(one, two, three)
    // -> error. just is only one value
    
    observable.subscribe { event in
        print(event)
        // next(1)
        // completed
    }

    observable2.subscribe { event in
        print(event)
        // next(1)
        // next(2)
        // next(3)
        // completed
    }

    observable3.subscribe { event in
        // next([1, 2, 3])
        // completed
        print(event)
    }
    
    observable4.subscribe { event in
        print(event)
        // next(1)
        // next(2)
        // next(3)
        // completed
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
        // element is get value, only next event
        if let element = event.element {
            print(element)
            // 1
            // 2
            // 3
        }
    }
    
    observable4.subscribe(onNext: { element in
        print(element)
    })
}

example(of: "empty") {
    let observable = Observable<Void>.empty()
    observable.subscribe(onNext: { element in
        print(element)
    }, onCompleted: {
        print("complete")
    })
}

example(of: "never") {
    let observable = Observable<Any>.never()
    observable.subscribe(onNext: { element in
        print(element)
    }, onCompleted: {
        print("complete")
    })
}

example(of: "range") {
    let observable = Observable<Int>.range(start: 1, count: 10)
    observable.subscribe(onNext: { i in
        let double = i * 2
        print(double)
    })
}

example(of: "dispose") {
    let observable = Observable.of("A", "B", "C")
    let disposeBag = DisposeBag()
    let subscription = observable.subscribe {
        print($0)
    }
    .addDisposableTo(disposeBag)
}

example(of: "create") {
    enum MyError: Error {
        case anError
    }

    let disposeBag = DisposeBag()
    Observable<String>.create { observer in
        observer.onNext("1")
        observer.onError(MyError.anError)
        observer.onCompleted()
        observer.onNext("?")
        return Disposables.create()
    }
    .subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("disposed") }
    )
    .addDisposableTo(disposeBag)
}
//    1
//    anError
//    disposed
// not call onCompleted, onNext("?")

example(of: "deferred") {
    let disposeBag = DisposeBag()
    var flip = false
    let factory: Observable<Int> = Observable.deferred({
        flip = !flip
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    })
    
    for _ in 0...3 {
        factory.subscribe(onNext: {
            print($0, terminator: "")
        })
        .addDisposableTo(disposeBag)
        print() // \n
    }
}





//: [Next](@next)
