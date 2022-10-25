import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import RxRelay

class LoginViewController: UIViewController {
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
                    print("🙈눈이 감겼다🙈")
                } else {
                    view.eyeImageButton.setBackgroundImage(self.imageOpen, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = false
                    print("🐵눈이 떠졌다🐵")

                }
                self.toggleButton = !self.toggleButton
            })
            .disposed(by: view.disposeBag)
        
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
