//: Playground - noun: a place where people can play

import UIKit
import RxSwift

// refs: https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b

let helloSequence = Observable.just("Hello Rx")
let fibonacciSequence = Observable.from([0, 1, 1, 2, 3, 5, 8])
let dictSequence = Observable.from([1: "Hello", 2: "World"])

let subscription = helloSequence.subscribe { event in
    print(event)
}

//next(Hello Rx)
//completed

let helloSequence2 = Observable.from(["H", "e", "l", "l", "o"])
let dispose = DisposeBag()
let subscription2 = helloSequence2.subscribe { event in
    switch event {
    case .next(let value):
        print(value)
    case .error(let error):
        print(error)
    case .completed:
        print("completed")
    }
}

let bag = DisposeBag()
let observable = Observable.just("Hello Rx!!!")
let subscription3 = observable.subscribe(onNext: {
  print($0)
})
subscription3.addDisposableTo(bag)

var publishSubject = PublishSubject<String>()
publishSubject.onNext("hello")
publishSubject.onNext("keigo")

let subscription4 = publishSubject.subscribe(onNext: {
    print($0)
}).addDisposableTo(bag)

publishSubject.onNext("hello2")
publishSubject.onNext("keigo2")

let subscription5 = publishSubject.subscribe(onNext: {
    print($0)
})

publishSubject.onNext("keigo learn RxSwift")

//hello2
//keigo2
//keigo learn RxSwift
//keigo learn RxSwift


// map

Observable<Int>.of(1, 2, 3, 4).map { value in
    return value * 10
    }.subscribe(onNext: {
        print($0)
})


// flat map

let sequence1 = Observable<Int>.of(1, 2)
let sequence2 = Observable<Int>.of(5, 6)
let sequence3 = Observable<Int>.of(3, 4)

let sequenceOfSequences = Observable.of(sequence1, sequence3, sequence2)

sequenceOfSequences.flatMap { return $0 }.subscribe(onNext: {
    print($0)
})

// Scan
//Scan starts with an initial seed value and is used to aggregate values just like reduce in Swift.


print("Scan")
Observable.of(1, 2, 3, 4, 5).scan(5) { seed, value in
    return seed + value
}.subscribe(onNext: {
    print($0)
})


// Side Effects

print("Side Effects")
Observable.of(1, 2, 3, 4, 5).do(onNext: {
    $0 * 10
}).subscribe(onNext: {
    print($0)
})


// Schedulers

let publish1 = PublishSubject<Int>()
let publish2 = PublishSubject<Int>()

let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

print("scheduler")
Observable.of(publish1, publish2)
    .observeOn(concurrentScheduler)
    .merge()
    .subscribeOn(MainScheduler())
    .subscribe(onNext: {
        print($0)
    })

publish1.onNext(20)
publish2.onNext(60)

