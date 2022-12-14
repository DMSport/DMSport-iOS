import UIKit
import RxSwift
import RxCocoa
import Moya
import RxMoya

class MyPageVM {
    private let disposeBag = DisposeBag()
    let mainProvider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    
    struct Input {
        let buttonDidTap: Driver<Void>
    }
    
    struct Output {
        let name: BehaviorRelay<String>
        let email: BehaviorRelay<String>
        let authString: BehaviorRelay<String>
    }
    
    func transform(_ input: Input) -> Output {
        let name = BehaviorRelay<String>(value: "")
        let email = BehaviorRelay<String>(value: "")
        let authString = BehaviorRelay<String>(value: "")
        
        self.mainProvider.rx.request(.getSearchMyInformation)
            .subscribe { res in
                switch res {
                case .success(let result):
                    debugPrint(result)
                    switch result.statusCode {
                    case 200:
                        if let data = try? JSONDecoder().decode(GetSearchMyInFormation.self, from: result.data) {
                            name.accept(data.name)
                            email.accept(data.email)
                            authString.accept(data.authority)
                        }
                    default:
                            print("default")
                    }
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
        

        return Output(name: name, email: email, authString: authString)
    }
}
