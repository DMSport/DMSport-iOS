import UIKit
import RxMoya
import Moya
import RxSwift
import RxCocoa

class ChangePasswordViewController: UIViewController {
    
    let provider = MoyaProvider<MyAPI>()
    var toggleButton = false
    let imageClose = UIImage(named: "CloseEye")
    let imageOpen = UIImage(named: "OpenEye")
    var email = ""
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "BaseColor")
                
        let view = ChangePasswordView()
        view.updateWith(self)
        
        view.firstEyeImageButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(self.toggleButton) {
                    view.firstEyeImageButton.setBackgroundImage(self.imageClose, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = true
                } else {
                    view.firstEyeImageButton.setBackgroundImage(self.imageOpen, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = false
                }
                self.toggleButton = !self.toggleButton
            })
            .disposed(by: view.disposeBag)
        
        view.secondEyeImageButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(self.toggleButton) {
                    view.secondEyeImageButton.setBackgroundImage(self.imageClose, for: UIControl.State.normal)
                    view.firstTextField.isSecureTextEntry = true
                } else {
                    view.secondEyeImageButton.setBackgroundImage(self.imageOpen, for: UIControl.State.normal)
                    view.firstTextField.isSecureTextEntry = false
                }
                self.toggleButton = !self.toggleButton
            })
            .disposed(by: view.disposeBag)
        
        view.mainButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                view.repasswordCheak(view.secondTextField)
                view.passwordTextFieldTap(view.firstTextField, view.errorMassgeText, view.errorImage, self)
                
                if(view.secondTextField.text == nil || view.secondTextField.text!.isEmpty) {
                    print("새로운비번이 없서")
                    return
                }
                
                self.provider.rx.request(.putChangePassword(PutChangePassword(email: EmailSaver.saver.getSavedEmail()!, newPassword: view.secondTextField.text!))).subscribe { response in
                    switch response {
                    case .success(let response):
                        print(response.statusCode)
                        break
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }
            })
            .disposed(by: view.disposeBag)
    }
}
