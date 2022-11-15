import UIKit
extension ChangePasswordView {
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
            firstTextField.text = String(password[..<index])
            
            return .over
        }
        
        if(password.count < 8) {
            return .under
        }
        if(secondTextField.text == firstTextField.text) {
            return .normal
        }
        return .error
    }
    
    private func reCheakPassword(_ Password: String) -> IdRange {
        if(Password.count > 20) {
            let index = Password.index(Password.startIndex, offsetBy: 20)
            secondTextField.text = String(Password[..<index])
            
            return .over
        }
        
        if(Password.count < 8) {
            return .under
        }
        if(secondTextField.text == firstTextField.text) {
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
                    self.ErrorMassages.isHidden = false
                    self.ErrorMassages.textColor = .red
                    self.ErrorMassages.text = "최소 8글자~ 최대 20글자"
                    self.errorImage.isHidden = false
                    rePasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                case .under:
                    self.ErrorMassages.isHidden = false
                    self.ErrorMassages.textColor = .red
                    self.ErrorMassages.text = "최소 8글자~ 최대 20글자"
                    self.errorImage.isHidden = false
                    rePasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                case .sign:
                    self.ErrorMassages.isHidden = false
                    self.ErrorMassages.textColor = .blue
                    self.ErrorMassages.text = "대소문자, 숫자, 특수문자"
                    self.errorImage.isHidden = false
                    rePasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                case .normal:
                    self.ErrorMassages.isHidden = false
                    self.ErrorMassages.textColor = .blue
                    self.ErrorMassages.text = "사용가능 합니다"
                    self.errorImage.isHidden = true
                    rePasswordTextField.layer.borderColor = UIColor.blue.cgColor
                    
                case .error:
                    self.ErrorMassages.isHidden = false
                    self.ErrorMassages.textColor = .red
                    self.ErrorMassages.text = "비밀번호가 일치하지 않습니다"
                    self.errorImage.isHidden = false
                    rePasswordTextField.layer.borderColor = UIColor.red.cgColor
                    
                }
            }).disposed(by: disposeBag)
    }
    
    
    func passwordTextFieldTap(_ checkPasswordTextField: UITextField,_ errorText: UILabel, _ errorImage: UIImageView,_ controller: UIViewController) {
        checkPasswordTextField.rx.text.orEmpty
            .map(checkPassword(_:))
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
                    checkPasswordTextField.layer.borderColor = UIColor.blue.cgColor
                    
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
