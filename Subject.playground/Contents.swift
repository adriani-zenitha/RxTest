import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

print("\nPublishSubject: 0 before subscription")
let ps = PublishSubject<String>()

ps.onNext("PS before 1")
ps.onNext("PS before 2")

ps.subscribe(onNext: { val in
    print(val)
}, onCompleted: {
    print("PS completed")
})

ps.onNext("PS after 1")
ps.onNext("PS after 2")
ps.onCompleted()
ps.onNext("PS after 3")
ps.onNext("PS after 4")


print("\nBehaviorSubject: 1 before subscription")
let bs = BehaviorSubject<String>(value: "BS initial")

bs.onNext("BS before 1")
bs.onNext("BS before 2")

bs.subscribe(onNext: { val in
    print(val)
})

bs.onNext("BS after 1")
bs.onNext("BS after 2")

//bs.subscribe(onNext: { val in
//    print(val)
//})
//
//bs.onNext("BS after 3")
//bs.onNext("BS after 4")


print("\nReplaySubject: n before subscription")
let rs = ReplaySubject<String>.create(bufferSize: 3)

rs.onNext("RS before 1 - excluded")
rs.onNext("RS before 2 - excluded")
rs.onNext("RS before 3")
rs.onNext("RS before 4")
rs.onNext("RS before 5")

rs.subscribe(onNext: { val in
    print(val)
})

rs.onNext("RS after 1")
rs.onNext("RS after 2")


print("\nBehaviorRelay")
let br = BehaviorRelay<String>(value: "BR initial")

br.asObservable().subscribe(onNext: { val in
    print(val)
})

br.accept("BR after 1")
br.accept("BR after 2")
