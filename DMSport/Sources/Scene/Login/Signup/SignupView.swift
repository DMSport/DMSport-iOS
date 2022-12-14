import UIKit
import Foundation
import RxSwift
import RxCocoa
import Then
import SnapKit

class SignupView: BaseSignView {
    
    internal lazy var rewriteTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.placeholder = "비밀번호를 다시 입력해 주세요"
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    internal lazy var eyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    internal lazy var reEyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    internal lazy var reErrorMassage = UILabel().then {
        $0.text = "에러다에러야!"
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.isHidden = true
    }
    
    internal lazy var reErrorImage = UIImageView().then {
//        let imageName = "errorImage"
        let image = UIImage(systemName: "x.circle")
        let imageView = UIImageView(image: image!)
        $0.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        $0.backgroundColor = .red
        $0.isHidden = true
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        let image = UIImage(named: "nButton")
        mainButton.setBackgroundImage(image, for: UIControl.State.normal)
        
        firstText.text = "시작하기"
        firstTextField.placeholder = "이름(실명)"
        secondTextField.placeholder = "비밀번호는 대소문자, 특수문자 포함 8~30자"
        secondTextField.textContentType = .password
        secondTextField.isSecureTextEntry = true
        
        [
            rewriteTextField,
            reEyeImageButton,
            eyeImageButton,
            reErrorMassage,
            reErrorImage
            
        ].forEach { controller.view.addSubview($0) }
        
        let width = controller.view.frame.width / 430.0
//        let height = controller.view.frame.height / 932.0
       
       rewriteTextField.snp.makeConstraints {
           $0.top.equalTo(secondTextField.snp.bottom).offset(32)
           $0.leading.equalTo(secondTextField.snp.leading)
           $0.height.equalTo(50)
           $0.width.equalTo(355)
       }
       
       reEyeImageButton.snp.makeConstraints {
           $0.top.equalTo(firstTextField.snp.bottom).offset(52)
           $0.trailing.equalToSuperview().inset(50 * width)
           $0.width.equalTo(28)
           $0.height.equalTo(13)
       }
       
       eyeImageButton.snp.makeConstraints {
           $0.top.equalTo(secondTextField.snp.bottom).offset(52)
           $0.trailing.equalToSuperview().inset(50 * width)
           $0.width.equalTo(28)
           $0.height.equalTo(13)
       }
        
        reErrorMassage.snp.makeConstraints {
            $0.top.equalTo(rewriteTextField.snp.bottom).offset(5)
            $0.leading.equalTo(rewriteTextField.snp.leading).inset(10)
        }
        
        reErrorImage.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom).offset(45)
            $0.trailing.equalToSuperview().inset(80)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
}
