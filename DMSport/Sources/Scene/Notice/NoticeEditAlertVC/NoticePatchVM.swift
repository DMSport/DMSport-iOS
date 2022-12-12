import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class NoticePatchVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let newTitle: String
        let newContent: String
        let noticeID: Int
        let buttonDidTap: Signal<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let patchResult = PublishRelay<Bool>()
        
        mainProvider.request(.patchNoticeCorrection(input.newTitle, input.newContent, input.noticeID)) { res in
            switch res {
            case .success(let result):
                debugPrint(result)
                switch result.statusCode {
                case 204:
                    patchResult.accept(true)
                default:
                    patchResult.accept(false)
                }
            case .failure(let error):
                print(error)
            }
        }
            
//        self.mainProvider.rx.request(.patchNoticeCorrection(input.newTitle, input.newContent, input.noticeID))
//            .subscribe { res in
//                    switch res {
//                    case .success(let result):
//                        debugPrint(result)
//                        switch result.statusCode {
//                        case 204:
//                            patchResult.accept(true)
//                        default:
//                            patchResult.accept(false)
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//            }.disposed(by: disposeBag)
        
        return Output(result: patchResult)
    }
}
