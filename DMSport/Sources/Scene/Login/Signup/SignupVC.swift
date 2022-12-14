import UIKit
import Moya
import SnapKit
import RxSwift
import RxCocoa
import Then

class SignUpViewController: UIViewController {
    let provider = MoyaProvider<MyAPI>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        
        let imageClose = UIImage(named: "CloseEye")
        let imageOpen = UIImage(named: "OpenEye")
        var toggleButton = false
        
        let view = SignupView()
        
        view.repasswordCheak(view.rewriteTextField)
        view.mainButton.rx.tap
            .subscribe(onNext: { [weak self] in
                view.SignupButtonTap(view.secondTextField, view.firstTextField, view.errorMassgeText, view.errorImage, self!)
                view.SignupButtonTap(view.rewriteTextField, view.firstTextField, view.errorMassgeText, view.errorImage, self!)
            }).disposed(by: view.disposeBag)
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
