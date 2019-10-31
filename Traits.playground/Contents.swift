import UIKit
import RxSwift
import RxCocoa

enum ResultError: Error {
    case overflow
    case invalidInput
}

let disposeBag = DisposeBag()

print("\nSingle: success, error")
func authenticate(_ userName: String) -> Single<[String: String]> {
    return Single.create { observer in
            if userName != "" {
                /*
                Web API for response.
                On success parse and return the response.
                */
                sleep(1)
                observer(.success(["status": "success", "user": userName, "token": "sdfhuie12lkjsdf"]))
            } else {
                observer(.error(ResultError.invalidInput))
            }
        return Disposables.create()
    }
}

authenticate("Woody").subscribe(onSuccess: { result in
    print(result)
}, onError: { error in
    print(error)
}).disposed(by: disposeBag)


print("\nCompletable: completed, error")
func uploadImage(data: String) -> Completable {
    return Completable.create { observer in
        let success = false
        /*
            Web API to upload the image to server.
            On success it will set success = true
        */
        sleep(1)
        if success {
            observer(.completed)
        } else {
            observer(.error(ResultError.overflow))
        }
        return Disposables.create()
    }
}

uploadImage(data: "Buzz").subscribe(onCompleted: {
    print("uploadImage Buzz completed")
}, onError: { error in
    print(error)
}).disposed(by: disposeBag)


print("\nMaybe: success, completed, error")
struct Itineary {
    let id: String
    let description: String
    let price: Double
}

func updateItineraries() -> Maybe<Itineary> {
    return Maybe.create { observer in
        /*
        Update the record in the local database.
        Current requirment is, on successful addition of new record, just let us know the caller.
        In future, caller might need the record back.
        */
        sleep(1)
        // Just completion event
        observer(.completed)
        
        //required success
        let itineary = Itineary(id:"a", description: "asd", price: 12.44)
        observer(.success(itineary))
        
        //On error
        observer(.error(ResultError.overflow))
        
        return Disposables.create()
    }
}

updateItineraries().subscribe(onSuccess: { result in
    print(result)
}, onError: { error in
    print(error)
}, onCompleted: {
    print("updateItineraries completed")
}).disposed(by: disposeBag)
