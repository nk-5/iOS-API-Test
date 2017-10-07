//: [Previous](@previous)

import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "ignoreElement") {
    
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    strikes.ignoreElements().subscribe { _ in
        print("You're out!")
    }
    .addDisposableTo(disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onCompleted()
//    --- Example of: ignoreElement ---
//    You're out!
//    not output onNext event
}

example(of: "elementAt") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    strikes.elementAt(2).subscribe(onNext: { event in
        print(event)
        print("You're out!")
    })
    .addDisposableTo(disposeBag)
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X") // when this event subscribe, output print
}

example(of: "filter") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3, 4, 5, 6).filter { integer in
        integer % 2 == 0
    }
    .subscribe(onNext: {
        print($0)
    })
    .addDisposableTo(disposeBag)
}

example(of: "skip") {
    let disposeBag = DisposeBag()
    Observable.of("A", "B", "C", "D", "E", "F")
        .skip(3)
        .subscribe(onNext: {
            print($0)
        })
        .addDisposableTo(disposeBag)
    // output D, E, F
}

example(of: "skipWhile") {
    let disposeBag = DisposeBag()
    Observable.of(2, 2, 3, 4, 4)
        .skipWhile { integer in
            integer % 2 == 0
        }
        .subscribe(onNext: {
            print($0)
        })
        .addDisposableTo(disposeBag)
    
    // output 3, 4, 4
    // skipWhileの条件の間skipする
}

example(of: "skipUntil") {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject.skipUntil(trigger).subscribe(onNext: {
        print($0)
    })
    .addDisposableTo(disposeBag)
    
    subject.onNext("A")
    subject.onNext("B")
    
    trigger.onNext("X")
    
    subject.onNext("C")
    
    // output C only
}

// Taking operators

example(of: "take") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3, 4, 5, 6)
        .take(3).subscribe(onNext: {
            print($0)
        })
    .addDisposableTo(disposeBag)
    // output 1, 2, 3
}

example(of: "takeWhileWithIndex") {
    let disposeBag = DisposeBag()
    Observable.of(2, 2, 4, 4, 6, 6)
        .takeWhileWithIndex { integer, index in
            integer % 2 == 0 && index < 3
        }
        .subscribe(onNext: {
            print($0)
        })
        .addDisposableTo(disposeBag)
    // output 2, 2, 4
}

example(of: "takeUntil") {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject.onNext("1")
    subject.takeUntil(trigger).subscribe(onNext: {
        print($0)
    })
    .addDisposableTo(disposeBag)
    
    subject.onNext("2")
    subject.onNext("3")
    trigger.onNext("X")
    subject.onNext("4")
    // output 2, 3  -> trigger onNext after subject onNext not output
}

// Distinct operators

example(of: "distinctUntilChanged") {
    let disposeBag = DisposeBag()
    Observable.of("A", "A", "A", "B", "B", "A")
        .distinctUntilChanged().subscribe(onNext: {
            print($0)
        })
    .addDisposableTo(disposeBag)
    
    // 連続したevent.elementはsubscribeしない
}


example(of: "distinctUntilChanged()") {
    let disposeBag = DisposeBag()
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
        .distinctUntilChanged { a, b in
            guard let aWords = formatter.string(from: a)?.components(separatedBy: " "),
            let bWords = formatter.string(from: b)?.components(separatedBy: " ")
                else {
                    return false
                }
            var containMatch = false
//            print(aWords)
            print(bWords)
            for aWord in aWords {
                for bWord in bWords {
                    if aWord == bWord {
                        containMatch = true
                        break
                    }
                }
            }
            
            return containMatch
        }
        .subscribe(onNext: {
            print($0)
        })
        .addDisposableTo(disposeBag)
}




























//: [Next](@next)
