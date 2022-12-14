import Foundation
import UIKit
import RxSwift
import RxCocoa

extension SignupView {
    enum IdRange {
        case over
        case under
        case sign
        case normal
        case error
    }
    
    private func checkPassword(_ password: String) -> IdRange {
        
        if(password.count > 20) {
            let index = password.index(password.startIndex, offsetBy: 20)
            secondTextField.text = String(password[..<index])
            
            return .over
        }
        
        if(password.count < 8) {
            return .under
        }
        if(secondTextField.text == rewriteTextField.text) {
            return .normal
        }
        return .error
    }
    
    private func reCheakPassword(_ rePassword: String) -> IdRange {
        if(rePassword.count > 20) {
            let index = rePassword.index(rePassword.startIndex, offsetBy: 20)
            rewriteTextField.text = String(rePassword[..<index])
            
            return .over
        }
        
        if(rePassword.count < 8) {
            return .under
        }
        if(secondTextField.text == rewriteTextField.text) {
            return .normal
        }
        return .error
    }
    
    func repasswordCheak(_ rePasswordTextField: UITextField) {
        rePasswordTextField.rx.text.orEmpty
            .map(reCheakPassword(_:))
            .subscribe(onNext: { errorMassge in
                switch errorMassge {
                case .over:
                    print("너무 길어")
                case .under:
                    print("너무 짫아")
                case .normal:
                    print("오케이 통과")
                case .sign:
                    print("대소문자 사용가능")
                case .error:
                    print("에러다 에러야")
                }
            }).disposed(by: disposeBag)
    }
    
    
    func SignupButtonTap(_ checkPasswordTextField: UITextField,_ idTextField: UITextField,_ errorText: UILabel, _ errorImage: UIImageView,_ controller: UIViewController) {
        checkPasswordTextField.rx.text.orEmpty
            .map(checkPassword(_:))
            .take(1)
            .subscribe(onNext: { errorMassge in
                switch errorMassge{
                case .over:
                    errorText.isHidden = false
                    errorText.textColor = .red
                    errorText.text = "최소 8글자~ 최대 20글자"
                    errorImage.isHidden = false
                    checkPasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                case .under:
                    errorText.isHidden = false
                    errorText.textColor = .red
                    errorText.text = "최소 8글자~ 최대 20글자"
                    errorImage.isHidden = false
                    checkPasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                case .sign:
                    errorText.isHidden = false
                    errorText.textColor = .blue
                    errorText.text = "대소문자, 숫자, 특수문자"
                    errorImage.isHidden = false
                    checkPasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                case .normal:
                    errorText.isHidden = false
                    errorText.textColor = .blue
                    errorText.text = "사용가능 합니다"
                    checkPasswordTextField.layer.borderColor = UIColor(named: "Primary2")?.cgColor
                    let GmailCertificationVC = GmailCertificationViewController()
                    GmailCertificationVC.password = checkPasswordTextField.text!
                    GmailCertificationVC.id = idTextField.text!
                    print("이름: \(GmailCertificationVC.id)")
                    print("비번: \(GmailCertificationVC.password)")
                    
                    controller.navigationController?.pushViewController(GmailCertificationVC, animated: true)
                    
                case .error:
                    errorText.isHidden = false
                    errorText.textColor = .red
                    errorText.text = "비밀번호가 일치하지 않습니다"
                    errorImage.isHidden = false
                    checkPasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                }
            })
            .disposed(by: disposeBag)
    }
}
