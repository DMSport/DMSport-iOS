import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class PositionVoteVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let buttonDidTap: Signal<Void>
        let voteID: Int
    }
    
    struct Output {
        let voteResult: PublishRelay<Bool>
    }
    
    func transfrom(_ input: Input) -> Output {
        let voteResult = PublishRelay<Bool>()
        
        mainProvider.request(.postVoteAndrevoke(_voteID: input.voteID)) { res in
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
        }
        
        return Output(voteResult: voteResult)
    }
}
