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
        
        
        if adminBool {
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
        } else if managerBool {
            self.mainProvider.rx.request(.postNoticeRegistrationClub(_title: input.newTitle, _content: input.newContent, _type: type))
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
        }
        

        return Output(result: postResult)
    }
}
