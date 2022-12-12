import Foundation

import RxSwift
import RxCocoa
import Moya

class CategoryNoticeVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let getNotices: Driver<Void>
        let loadDetail: Signal<IndexPath>
        let editIndex: Signal<Int>
    }
    
    struct Output {
        let allNotices: BehaviorRelay<[Notice]>
        let detailIndex: Signal<Int>
        let editIndex: Signal<Int>
    }
    
    func transfrom(_ input: Input) -> Output {
        let allNotices = BehaviorRelay<[Notice]>(value: [])
        let detailIndex = PublishRelay<Int>()
        let editIndex = PublishRelay<Int>()
        
        self.mainProvider.rx.request(.getAllSearchNoticeList)
            .subscribe { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 200:
                        if let data = try? JSONDecoder().decode(GetAllSearchNoticeList.self, from: result.data) {
                            allNotices.accept(data.notices.filter { $0.type != "ALL" })
                        } else {
                            debugPrint(res)
                        }
                    default:
                        break
                    }
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        
        input.loadDetail.asObservable()
            .subscribe(onNext: { index in
            let value = allNotices.value
                detailIndex.accept(value[index.row].id)
        }).disposed(by: disposeBag)
        
        input.editIndex.asObservable()
            .subscribe(onNext: { index in
                let value = allNotices.value
                editIndex.accept(value[index].id)
            })
            .disposed(by: disposeBag)

        return Output(allNotices: allNotices, detailIndex: detailIndex.asSignal(), editIndex: editIndex.asSignal())
    }
}
