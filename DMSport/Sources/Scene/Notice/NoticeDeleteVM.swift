import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class NoticeDeleteVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let noticeID: Int
        let buttonDidTap: Signal<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let deleteResult = PublishRelay<Bool>()
        
        self.mainProvider.rx.request(.deleteNotice(input.noticeID))
            .subscribe {  res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 204:
                        deleteResult.accept(true)
                    default:
                        deleteResult.accept(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        
        return Output(result: deleteResult)
    }
}
