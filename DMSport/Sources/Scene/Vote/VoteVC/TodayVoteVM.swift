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
        let voteObject: PublishRelay<GetToDayVoteSearch>
        let todayVotes: BehaviorRelay<[Vote]>
        let detailIndex: Signal<Int>
//        let categoryName: PublishRelay<String>
        let categoryName: BehaviorRelay<String>
    }
    
    func transfrom(_ input: Input) -> Output {
        let voteObject = PublishRelay<GetToDayVoteSearch>()
        let todayVotes = BehaviorRelay<[Vote]>(value: [])
        let detailIndex = PublishRelay<Int>()
        let categoryName = BehaviorRelay<String>(value: "")
        
        input.type.asObservable()
            .flatMapLatest { type -> Single<GetToDayVoteSearch> in
                self.mainProvider.rx.request(.getToDayVoteSearch(_type: "\(type)"))
                    .map(GetToDayVoteSearch.self)
                    .map {
                        voteObject.accept($0)
                        todayVotes.accept($0.vote)
                        categoryName.accept(type)
                        return $0
                    }
                    .catch { error in
                        return Single.error(MyAPIError.empty)
                    }
            }.subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        
        input.loadDetail.asObservable()
            .subscribe(onNext: {
                detailIndex.accept($0.row)
            }).disposed(by: disposeBag)
        
        return Output(voteObject: voteObject, todayVotes: todayVotes, detailIndex: detailIndex.asSignal(), categoryName: categoryName)
    }
}
