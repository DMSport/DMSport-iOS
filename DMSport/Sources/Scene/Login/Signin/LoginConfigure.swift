import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay

extension LoginView {
    func LoginButtonTap(_ controller: UIViewController) {
        self.errorImage.isHidden = false
        self.ErrorMassages.isHidden = false
        self.errorMassgeText.isHidden = false
        
        firstTextField.rx.text
            .orEmpty
            .map{ _ in self.loginVM.validationEmail() }
            .subscribe(onNext: { error in
                self.ErrorMassages.textColor = error ? .blue : .red
                self.firstTextField.layer.borderColor = error ? UIColor.blue.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
        secondTextField.rx.text
            .orEmpty
            .map{ _ in self.loginVM.validationPassword() }
            .subscribe(onNext: { error in
                self.errorMassgeText.textColor = error ? DMSportIOSAsset.Color.subtitleColor.color : .red
                self.secondTextField.layer.borderColor = error ? DMSportIOSAsset.Color.subtitleColor.color.cgColor : DMSportIOSAsset.Color.errorColor.color.cgColor
            })
            .disposed(by: disposeBag)
    }
    
    
    @objc func signupButtonTap(_ sender: UIButton!,_ controller: UIViewController){
        let signupVC = SignUpViewController()
        controller.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func nextButtonTap(){
    }
}
