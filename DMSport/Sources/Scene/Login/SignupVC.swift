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
        setupNavigationController()
        
        let view = SignupView()
        view.mainButton.rx.tap
            .bind { [weak self] in
                view.SignupButtonTap(view.secondTextField, view.firstTextField, view.errorMassgeText, view.errorImage, self!)
                view.SignupButtonTap(view.rewriteTextField, view.firstTextField, view.errorMassgeText, view.errorImage, self!)
                print("🐊:: LoginButton!")
                print("🥭 gotoGmailCertificationVC 🥭")
            }
            .disposed(by: view.disposeBag)
        view.updateWith(self)
    }
    
    func setupNavigationController() {

        let bar: UINavigationBar! = self.navigationController?.navigationBar

        bar.backgroundColor = .clear
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.isTranslucent = true
        let bellNavigetionItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: nil, action: nil)

        navigationItem.rightBarButtonItem = bellNavigetionItem
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
