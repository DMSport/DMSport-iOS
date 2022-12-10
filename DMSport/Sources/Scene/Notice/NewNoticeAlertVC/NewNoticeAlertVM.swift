import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

//final class Service {
//    let provider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
//
//    func post(title: String, content: String, type: String) -> Single<NetworkingResult> {
//        return provider.rx.request(.postNoticeRegistrationAdmin(_type: type))
//            .map{ _ -> NetworkingResult in return .createOk }
//            .catch{ [unowned self] in return .just(setNetworkError($0))}
//
//    }
//}

class NewNoticeAlertVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let newTitle: Driver<String>
        let newContent: Driver<String>
        let category: Driver<IndexPath>
        let buttonDidTap: Signal<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
//        let data = Driver.combineLatest(input.newTitle, input.newContent, input.category)
        let postResult = PublishRelay<Bool>()
        
//        input.buttonDidTap
//            .withLatestFrom(data)
//            .asObservable()
//            .flatMap { title, content, category in
//                self.mainProvider.request(.postNoticeRegistrationAdmin(title, content, category), completion: <#Completion#>)
//            }
        
//        self.mainProvider.rx.request(.postNoticeRegistrationAdmin(PostNoticeRegistrationAdmin(title: input.newTitle, content: data.content)))
//            .subscribe( { res in
//                switch res {
//                case .success(let result):
//                    debugPrint(result)
//                    switch result.statusCode {
//                    case 200:
                        postResult.accept(true)
//                    default:
//                        break
//                    }
//                case .failure(_):
//                    postResult.accept(false)
//                }
//            }).disposed(by: disposeBag)

        return Output(result: postResult)
    }
}
