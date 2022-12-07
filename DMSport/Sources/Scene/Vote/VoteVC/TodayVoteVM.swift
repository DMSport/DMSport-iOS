import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class TodayVoteVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let getVotes: Driver<Void>
        let type: Driver<String>
        let loadDetail: Signal<IndexPath>
    }
    
    struct Output {
        //        let voteObject: PublishRelay<GetToDayVoteSearch>
        let todayVotes: BehaviorRelay<[Vote]>
        let detailIndex: Signal<Int>
    }
    
    func transfrom(_ input: Input) -> Output {
        let voteObject = PublishRelay<GetToDayVoteSearch>()
        let todayVotes = BehaviorRelay<[Vote]>(value: [])
        let detailIndex = PublishRelay<Int>()
        
        input.type.asObservable()
            .flatMapLatest { type -> Single<GetToDayVoteSearch> in
                self.mainProvider.rx.request(.getToDayVoteSearch(_type: "\(type)"))
                    .map(GetToDayVoteSearch.self)
                    .map {
                        voteObject.accept($0)
                        todayVotes.accept($0.vote)
                        return $0
                    }
                    .catch { error in
                        return Single.error(MyAPIError.empty)
                    }
            }.subscribe {
                print($0)
//                voteObject.accept($0)
//                todayVotes.accept($0.vote)
            }
            .disposed(by: disposeBag)
        
        
        //        voteObject.asObservable()
        //            .subscribe(onNext: { data in
        //                let data =
        //            })
        //
        input.loadDetail.asObservable()
            .subscribe(onNext: { index in
                let value = todayVotes.value
                detailIndex.accept(value[index.row].voteID)
            }).disposed(by: disposeBag)
        
        return Output(todayVotes: todayVotes, detailIndex: detailIndex.asSignal())
    }
}
