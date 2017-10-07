//: [Previous](@previous)

import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}


example(of: "map") {
    let disposeBag = DisposeBag()
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    Observable<NSNumber>.of(123, 4, 56)
        .map {
            formatter.string(from: $0) ?? ""
        }
        .subscribe(onNext: {
            print($0)
        })
        .addDisposableTo(disposeBag)
}

example(of: "mapWithIndex") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3, 4, 5, 6)
        .mapWithIndex { integer, index in // value, key
            index > 2 ? integer * 2 : integer
        }
        .subscribe(onNext: {
            print($0)
        })
        .addDisposableTo(disposeBag)
}


struct Student {
    var score: Variable<Int>
}

example(of: "flatMap") {
    let disposeBag = DisposeBag()
    let nk5 = Student(score: Variable(80))
    let keigo = Student(score: Variable(90))
    
    let student = PublishSubject<Student>()
    
    student.asObservable().flatMap {
        $0.score.asObservable()
    }
    .subscribe(onNext: {
        print($0)
    })
    .addDisposableTo(disposeBag)
    
    student.onNext(nk5)
    nk5.score.value = 100
    student.onNext(keigo)
}

example(of: "flatMapLatest") {
    let disposeBag = DisposeBag()

    let nk5 = Student(score: Variable(80))
    let keigo = Student(score: Variable(90))
    
    let student = PublishSubject<Student>()
    student.asObservable().flatMapLatest {
        $0.score.asObservable()
    }
    .subscribe(onNext: {
        print($0)
    })
    .addDisposableTo(disposeBag)
    
    student.onNext(nk5)
    nk5.score.value = 120
    student.onNext(keigo)
    nk5.score.value = 10
    keigo.score.value = 5
    
//        --- Example of: flatMapLatest ---
//    80
//    120
//    90
//    5
}














//: [Next](@next)
