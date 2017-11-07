//: [Previous](@previous)

import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}


example(of: "startWith") {
    let numbers = Observable.of(2, 3, 4)
    let observable = numbers.startWith(1)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

// concat

example(of: "Observable.concat") {
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)
    let observable = Observable.concat([first, second])
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "concat") {
    let test = Observable.of("A", "B", "C")
    let test2 = Observable.of("D", "E", "F")
    let observable = test.concat(test2)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "concat one element") {
    let numbers = Observable.of(2, 3, 4)
    let observable = Observable.just(1).concat(numbers)
    observable.subscribe(onNext: { value in
        print(value)
    })
}

// Merging

example(of: "merge") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    let source = Observable.of(left.asObserver(), right.asObserver())
    let observable = source.merge()
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    var leftValues = ["iOS", "Android", "Linux"]
    var rightValues = ["PHP", "Swift", "Kotlin"]
    repeat {
        if arc4random_uniform(2) == 0 {
            if !leftValues.isEmpty {
                left.onNext("Left: " + leftValues.removeFirst())
            }
        } else if !rightValues.isEmpty {
            right.onNext("Right: " + rightValues.removeFirst())
        }
    } while !leftValues.isEmpty || !rightValues.isEmpty
    disposable.dispose()
}


example(of: "combineLatest") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    let observable = Observable.combineLatest(left, right, resultSelector: {
        lastLeft, lastRight in
        "\(lastLeft) \(lastRight)"
    })
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    print("> Sending a value to Left")
    left.onNext("Hello,")
    print("> Sending a value to Right")
    right.onNext("world")
    print("> Sending another value to Right")
    right.onNext("RxSwift")
    print("> Sending another value to Left")
    left.onNext("Hava a good day,")
    disposable.dispose()
    
//    let test = Observable.combineLatest(left, right) { ($0, $1) }.filter { !$0.0.isEmpty }
//    left.onNext("test")
//    right.onNext("keigo")
//    test.subscribe(onNext: { value in
//        print(value)
//    })
}

example(of: "combine user choice and value") {
    let choice : Observable<DateFormatter.Style> = Observable.of(.short, .long)
    let dates = Observable.of(Date())
    let observable = Observable.combineLatest(choice, dates) {
        (format,  when) -> String in
        let formatter = DateFormatter()
        formatter.dateStyle = format
        return formatter.string(from: when)
    }
    
    observable.subscribe(onNext: { value in
        print(value)
    })
    
}

example(of: "zip") {
    enum Weather {
        case cloudy
        case sunny
    }
    let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
    let right = Observable.of("Shiga", "Tokyo")
    let observable = Observable.zip(left, right) { weather, city in
        return "It's \(weather) in \(city)"
    }
    observable.subscribe(onNext: { value in
        print(value)
    })
}

// Triggers

example(of: "withLatestFrom") {
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()
    
//    let observable = button.withLatestFrom(textField)
    let observable = textField.sample(button)
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    textField.onNext("test")
    textField.onNext("keigo")
    
    button.onNext(())
}

//Switches

example(of: "amb") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    let observable = left.amb(right)
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    left.onNext("123")
    right.onNext("000")
    left.onNext("456")
    left.onNext("789")
    right.onNext("111")
    disposable.dispose()
    
    // output 123, 456, 789
}


example(of: "switchLatest") {
    let one = PublishSubject<String>()
    let two = PublishSubject<String>()
    let three = PublishSubject<String>()
    
    let source = PublishSubject<Observable<String>>()
    let observable = source.switchLatest()
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    source.onNext(one)
    one.onNext("some text from sequence one")
    two.onNext("some text from sequence two")
    
    source.onNext(two)
    two.onNext("More text from sequence two")
    one.onNext("and also from sequence one")
    
    source.onNext(three)
    two.onNext("Why don't you seem me?")
    one.onNext("I'm alone, help me")
    three.onNext("Hey it's three. I win.")
    
    source.onNext(one)
    one.onNext("Nope. It's me, one!")
    disposable.dispose()
    
    // latest source in observable stream event
    
//    --- Example of: switchLatest ---
//    some text from sequence one
//    More text from sequence two
//    Hey it's three. I win.
//    Nope. It's me, one!
}

example(of: "reduce") {
    let source = Observable.of(1, 3, 5, 7, 9)
    let observable = source.reduce(0, accumulator: +)
    observable.subscribe(onNext: { value in
        print(value) // output 25 only
    })
    
    // reduce first argument = The initial accumulator value.
//    let example = source.reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
}

example(of: "scan") {
    let source = Observable.of(1, 3, 5, 7, 9)
    let observable = source.scan(0, accumulator: +)
    observable.subscribe(onNext: { value in
        print(value) // output 1, 4, 9, 16, 25
    })
}





















//: [Next](@next)
