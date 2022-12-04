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
        let categoryRecentNotices: BehaviorRelay<[Admin]>
        let entireRecentNotices: BehaviorRelay<[Admin]>
    }
    
    func transform(_ input: Input) -> Output {
        let adminList = BehaviorRelay<[Admin]>(value: [])
        let managerList = BehaviorRelay<[Admin]>(value: [])
        
        self.mainProvider.rx.request(.getNewlyNotice)
            .subscribe { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 200:
                        if let data = try? JSONDecoder().decode(GetNewlyNotice.self, from: result.data) {
                            adminList.accept(data.admin)
                            managerList.accept(data.manager)
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
        return Output(categoryRecentNotices: managerList, entireRecentNotices: adminList)
    }
}
