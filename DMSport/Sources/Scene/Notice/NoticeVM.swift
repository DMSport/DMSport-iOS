import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class NoticeVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let getData: Driver<Void>
    }
    
    struct Output {
        let allNotices: BehaviorRelay<[Notice]>
    }
    func transfrom(_ input: Input) -> Output {
        let allNotices = BehaviorRelay<[Notice]>(value: [])
        
        self.mainProvider.rx.request(.getAllSearchNoticeList)
            .subscribe { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 200:
                        if let data = try? JSONDecoder().decode(GetAllSearchNoticeList.self, from: result.data) {
                            allNotices.accept(data.notices)
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
        
        return Output(allNotices: allNotices)
    }
}
