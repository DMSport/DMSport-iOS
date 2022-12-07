import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class NoticeDetailVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let noticeID: Int
        let getDetail: Driver<Void>
    }
    
    struct Output {
        let seeNotice: PublishRelay<GetNoticeDetilSearch?>
    }
    
    func transfrom(_ input: Input) -> Output {
        let seeDetail = PublishRelay<GetNoticeDetilSearch?>()
        
        self.mainProvider.rx.request(.getNoticeDetilSearch(_noticeID: input.noticeID))
            .subscribe { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 200:
                        if let data = try? JSONDecoder().decode(GetNoticeDetilSearch.self, from: result.data) {
                            seeDetail.accept(data)
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
        
        return Output(seeNotice: seeDetail)
    }
}
