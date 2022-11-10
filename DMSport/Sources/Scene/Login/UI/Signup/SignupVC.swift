import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let imageClose = UIImage(named: "CloseEye")
        let imageOpen = UIImage(named: "OpenEye")
        var toggleButton = false
        
        let view = SignupView()
        view.mainButton.rx.tap
            .bind { [weak self] in
                view.SignupButtonTap(view.secondTextField,view.errorMassgeText, view.errorImage, self!)
                view.SignupButtonTap(view.rewriteTextField,view.reErrorMassage, view.reErrorImage, self!)
                print("🥭 gotoGmailCertificationVC 🥭")
            }
            .disposed(by: view.disposeBag)
        view.updateWith(self)
        
        view.eyeImageButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(toggleButton) {
                    view.eyeImageButton.setBackgroundImage(imageClose, for: UIControl.State.normal)
                    view.rewriteTextField.isSecureTextEntry = true
                } else {
                    view.eyeImageButton.setBackgroundImage(imageOpen, for: UIControl.State.normal)
                    view.rewriteTextField.isSecureTextEntry = false
                }
                toggleButton = !toggleButton
            })
            .disposed(by: view.disposeBag)
        
        view.reEyeImageButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(toggleButton) {
                    view.reEyeImageButton.setBackgroundImage(imageClose, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = true
                } else {
                    view.reEyeImageButton.setBackgroundImage(imageOpen, for: UIControl.State.normal)
                    view.secondTextField.isSecureTextEntry = false
                }
                toggleButton = !toggleButton
            })
            .disposed(by: view.disposeBag)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
