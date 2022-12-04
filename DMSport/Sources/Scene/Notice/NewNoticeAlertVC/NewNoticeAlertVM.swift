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
        let buttonDidTap: Signal<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let title: String = ""
        let content: String = ""
        let postResult = PublishRelay<Bool>()
        
        self.mainProvider.rx.request(.postNoticeRegistrationAdmin(PostNoticeRegistrationAdmin(title: title, content: content)))
            .subscribe( { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 200:
                        postResult.accept(true)
                    default:
                        break
                    }
                case .failure(_):
                    postResult.accept(false)
                }
            }).disposed(by: disposeBag)
        
        return Output(result: postResult)
    }
}
