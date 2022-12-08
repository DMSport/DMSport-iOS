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
        
        //        input.voteID.asObservable()
        //            .flatMap { voteID -> Single<NetworkingResult> in
        //                self.mainProvider.rx.request(.postVoteAndrevoke(_voteID: voteID))
        //                    .map { _ -> NetworkingResult in return .deleteOk }
        //                    .catch { error in
        //                        return Single.error(MyAPIError.empty)
        //                    }
        //            }.subscribe(onNext: { res in
        //                switch res {
        //                case .deleteOk:
        //                    voteResult.accept(true)
        //                default:
        //                    voteResult.accept(false)
        //                }
        //            })
        //            .disposed(by: disposeBag)
        
        
        //        input.voteID.asObservable()
        //            .subscribe(onNext: { id in
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
        //            }).disposed(by: disposeBag)
        
        //        input.buttonDidTap.asObservable()
        //            .subscribe(onNext: {
        //                self.mainProvider.rx.request(.postVoteAndrevoke(_voteID: <#T##Int#>))
        //                    .subscribe { res in
        //                        switch res {
        //                        case .success(let result):
        //                            debugPrint(result)
        //                            switch result.statusCode {
        //                            case 204:
        //                                voteResult.accept(true)
        //                            default:
        //                                voteResult.accept(false)
        //                            }
        //                        case .failure(let error):
        //                            print(error)
        //                        }
        //                    }.disposed(by: self.disposeBag)
        //            }).disposed(by: disposeBag)
        
        return Output(voteResult: voteResult)
    }
}
