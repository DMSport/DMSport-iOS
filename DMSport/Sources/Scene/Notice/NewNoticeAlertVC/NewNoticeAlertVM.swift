import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class NewNoticeAlertVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let newTitle: String
        let newContent: String
        let category: String
        let buttonDidTap: Driver<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
//        let data = Driver.combineLatest(input.newTitle, input.newContent, input.category)
        var type = String()
        let postResult = PublishRelay<Bool>()
        
        switch input.category {
        case "전체":
            type = "ALL"
        case "배드민턴":
            type = "BADMINTON"
        case "축구":
            type = "SOCCER"
        case "농구":
            type = "BASKETBALL"
        case "배구":
            type = "VOLLEYBALL"
        default:
            print("default")
        }
        
        
//        input.buttonDidTap.asObservable()
////            .flatMap { buttonDidTap -> Single<NetworkingResult> in
////                self.mainProvider.rx.request(.postNoticeRegistrationAdmin(input.newTitle, input.newContent, type))
////            }
//            .subscribe {
//                self.mainProvider.rx.request(.postNoticeRegistrationAdmin(_title: input.newTitle, _content: input.newContent, _type: type))
//                    .subscriv
//            }
        
        
        self.mainProvider.rx.request(.postNoticeRegistrationAdmin(_title: input.newTitle, _content: input.newContent, _type: type))
            .subscribe { res in
                    switch res {
                    case .success(let result):
                        debugPrint(result)
                        switch result.statusCode {
                        case 201:
                            postResult.accept(true)
                        default:
                            postResult.accept(false)
                        }
                    case .failure(let error):
                        print(error)
                    }
            }.disposed(by: disposeBag)
        
        
//        self.mainProvider.rx.request(.postNoticeRegistrationAdmin(PostNoticeRegistrationAdmin(title: input.newTitle, content: data.content)))
//            .subscribe( { res in
//                switch res {
//                case .success(let result):
//                    debugPrint(result)
//                    switch result.statusCode {
//                    case 200:
//                        postResult.accept(true)
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
