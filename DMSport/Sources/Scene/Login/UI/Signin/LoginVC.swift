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
        
        
        let view = LoginView()
        view.forgetPassword.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                view.nextButtonTap()
            })
            .disposed(by: view.disposeBag)
        
        view.mainButton.rx.tap
            .bind{
                view.signupButtonTap(view.mainButton, self)
                print("회원가입으로😘")
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
                if(view.firstTextField.text! == nil || view.firstTextField.text!.isEmpty) {
                    print("이메일이 없서")
                    print(view.firstTextField.text!)
                    return
                }
                if(view.secondTextField.text! == nil || view.secondTextField.text!.isEmpty) {
                    print("인증번호가 없서")
                    print(view.secondTextField.text!)
                    return
                }
           
                self.provider.rx.request(.postSignIn(PostLoginRequest(email: view.firstTextField.text!, password: view.secondTextField.text!))).subscribe { response in
                    switch response {
                    case .success(let response):
                        print(response.statusCode)
                        print("🌈 이메일: \(view.firstTextField.text!)", "인증번호: \(view.secondTextField.text!)")
                        break
                    case .failure(let error):
                        print("에러: \(error)")
                    }
                }.disposed(by: view.disposeBag)
            })
        
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
