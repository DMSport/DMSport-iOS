import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let view = SignupView()
        view.mainButton.rx.tap
            .bind { [weak self] in
                view.SignupButtonTap(view.secondTextField,view.errorMassgeText, view.errorImage, self!)
                view.SignupButtonTap(view.rewriteTextField,view.reErrorMassage, view.reErrorImage, self!)
                print("🥭 gotoGmailCertificationVC 🥭")
            }
            .disposed(by: view.disposeBag)
        view.updateWith(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
