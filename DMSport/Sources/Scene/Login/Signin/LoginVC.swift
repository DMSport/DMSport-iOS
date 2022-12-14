import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import RxMoya
import Moya
import RxRelay

class LoginViewController: UIViewController {
    let provider = MoyaProvider<MyAPI>()
    let imageClose = UIImage(named: "CloseEye")
    let imageOpen = UIImage(named: "OpenEye")
    var toggleButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.navigationItem.title = ""
        self.navigationItem.backButtonTitle = ""
        
        let view = LoginView()
        view.forgetPassword.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                view.nextButtonTap()
            })
            .disposed(by: view.disposeBag)
        
        view.forgetPassword.rx.tap
            .bind {
                let CertificationVC = GmailCertificationViewController()
                self.navigationController?.pushViewController(CertificationVC, animated: true)
            }.disposed(by: view.disposeBag)
        
        view.mainButton.rx.tap
            .bind{
                view.signupButtonTap(view.mainButton, self)
            }
            .disposed(by: view.disposeBag)
        view.updateWith(self)
        
        view.eyeImageButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(self.toggleButton) {
                    view.eyeImageButton.setBackgroundImage(self.imageClose, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = true
                } else {
                    view.eyeImageButton.setBackgroundImage(self.imageOpen, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = false
                }
                self.toggleButton = !self.toggleButton
            })
            .disposed(by: view.disposeBag)
        
        view.loginButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(view.firstTextField.text! == "" || view.firstTextField.text!.isEmpty) {
                    print("이메일이 없서")
                    return
                }
                if(view.secondTextField.text! == "" || view.secondTextField.text!.isEmpty) {
                    print("인증번호가 없서")
                    return
                }
           
                self.provider.rx.request(.postSignIn(PostLoginRequest(email: view.firstTextField.text!, password: view.secondTextField.text!))).subscribe { response in
                    switch response {
                    case .success(let response):
                        print(response.statusCode)
                        print(String(data: response.data, encoding: .utf8) ?? "")
                        if let userDate = try? JSONDecoder().decode(TokenModel.self, from: response.data) {
                            KeyChain.create(key: Token.accessToken, token: userDate.access_token)
                            KeyChain.create(key: Token.refreshToken, token: userDate.refresh_token)
                            authority =  userDate.authority
                            if authority.contains("ADMIN") {
                                adminBool = true
                            } else if authority.contains("MANAGER") {
                                managerBool = true
                            }
                        }
                        self.dismiss(animated: true)
                        break
                    case .failure(let error):
                        print("에러: \(error)")
                    }
                }.disposed(by: view.disposeBag)
            }).disposed(by: view.disposeBag)
        
        view.firstTextField
            .rx.text
            .orEmpty
            .bind(to: view.loginVM.email)
            .disposed(by: view.disposeBag)
        
        view.secondTextField
            .rx.text
            .orEmpty
            .bind(to: view.loginVM.password)
            .disposed(by: view.disposeBag)
        
        view.loginVM.errorMsg
            .asObservable()
            .map { $0 }
            .bind(to: view.ErrorMassages.rx.text)
            .disposed(by: view.disposeBag)
        
        view.loginVM.errorMsg2
            .asObservable()
            .map { $0 }
            .bind(to: view.errorMassgeText.rx.text)
            .disposed(by: view.disposeBag)
        
        view.loginButton
            .rx.tap
            .do(onNext :{[unowned self] in
                self.view.endEditing(true)
            })
            .subscribe(onNext: {
                view.LoginButtonTap(self)
            })
            .disposed(by: view.disposeBag)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
