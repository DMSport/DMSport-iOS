import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class PositionVoteVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let buttonDidTap: Driver<Void>
        let voteID: Int
    }
    
    struct Output {
        let voteResult: PublishRelay<Bool>
    }
    
    func transfrom(_ input: Input) -> Output {
        let voteResult = PublishRelay<Bool>()
        
        self.mainProvider.rx.request(.postVoteAndrevoke(_voteID: input.voteID))
            .subscribe { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 204:
                        voteResult.accept(true)
                    default:
                        voteResult.accept(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        
        return Output(voteResult: voteResult)
    }
}
