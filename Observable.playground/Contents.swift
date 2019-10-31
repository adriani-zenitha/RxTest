import UIKit
import RxSwift

struct Person {
    let name: String
    let age: Int
    
    init(_ name: String, _ age: Int) {
        self.name = name
        self.age = age
    }
}


print("\nJust - single value")
let obsJust = Observable.just("Hello!")
obsJust.subscribe {
    print($0)
    print($0.element)
}


print("\nOf - multiple values")
let obsOf = Observable.of(1, 2, 3)
obsOf.subscribe { event in
    print(event)
    print(event.element)
}


print("\nFrom - array")
let obsFrom = Observable.from([Person("Harry", 20), Person("Hermione", 21), Person("Ron", 22)])
obsFrom.subscribe {
    print($0)
    print($0.element)
}


// Create Just
func myJust<E>(_ element: E) -> Observable<E> {
    return Observable.create { observer in
        observer.on(.next(element))
        observer.on(.completed)
        return Disposables.create()
    }
}

print("\nCreate myJust")
myJust(100).subscribe { event in
    switch event {
    case .next(let element):
        print(element)
    case .completed:
        print("myJust completed!")
    case .error:
        print("myJust error!")
    }
}


// Create
func getInt() -> Observable<Int> {
    return Observable.create { observer in
        print("getInt subscribed")
        for number in 1...3 {
            observer.onNext(number)
        }
        observer.onCompleted()
        return Disposables.create {
            print("getInt disposed")
        }
    }
}

print("\nCreate getInt")
getInt().subscribe(onNext: { el in
    print(el)
})

//getInt().debug("DEBUG").subscribe(onNext: { el in
//    print(el)
//})
