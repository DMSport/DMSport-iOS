//
//  MainSignupVC.swift
//  
//
//  Created by 박준하 on 2022/10/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class MainSignUpViewController: TestMomViewController {
    
    override func viewDidLoad() {
        fristText.text = "시작하기"
        fristTextField.placeholder = "이름(실명)"
        secondTextField.placeholder = "비밀번호를 입력해 주세요"
        rewriteTextField.placeholder = "비밀번호를 다시 입력해 주세요"
        rewriteTextField.layer.cornerRadius = 20
        rewriteTextField.layer.borderWidth = 0.5
        rewriteTextField.layer.borderColor = UIColor.black.cgColor
        rewriteTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        rewriteTextField.leftViewMode = .always
        rewriteTextField.textContentType = .password
        secondTextField.textContentType = .password
        rewriteTextField.isSecureTextEntry = true
        secondTextField.isSecureTextEntry = true
        
        let image = UIImage(named: "nButton")
        signupButton.setBackgroundImage(image, for: UIControl.State.normal)
        signupButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self!.SignupButtonTap()
                print("🐙🪄")
            })
            .disposed(by: disposeBag)
        
        setupLayout()
        super.viewDidLoad()
    }
    
    private lazy var rewriteTextField = UITextField().then {
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
    
    internal lazy var errorMassgeText = UILabel().then {
        $0.text = "에러다에러야!"
        $0.backgroundColor = .red
        $0.font = .systemFont(ofSize: 12.0, weight: .semibold)
//        $0.isHidden = true
    }
    
    enum IdRange {
        case over
        case under
        case sign
        case normal
    }
    
    private func checkPassword(_ password: String) -> IdRange {
        
        if(password.count > 20) {
            let index = password.index(password.startIndex, offsetBy: 20)
            self.secondTextField.text = String(password[..<index])
            
            return .over
        }
        if(password.count < 8) {
            return .under
        }
        
//        return .sign
        
        return .normal
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }

}


extension MainSignUpViewController {
    
   override func setupLayout() {
       super.setupLayout()
        [
            rewriteTextField,
            reEyeImageButton,
            eyeImageButton
        ].forEach { view.addSubview($0) }
       
       rewriteTextField.snp.makeConstraints {
           $0.top.equalTo(secondTextField.snp.bottom).offset(32)
           $0.leading.equalTo(secondTextField.snp.leading)
           $0.height.equalTo(50)
           $0.width.equalTo(355)
       }
       
       reEyeImageButton.snp.makeConstraints {
           $0.top.equalTo(fristTextField.snp.bottom).offset(52)
           $0.trailing.equalToSuperview().inset(40)
           $0.width.equalTo(28)
           $0.height.equalTo(13)
       }
       
       eyeImageButton.snp.makeConstraints {
           $0.top.equalTo(secondTextField.snp.bottom).offset(52)
           $0.trailing.equalToSuperview().inset(40)
           $0.width.equalTo(28)
           $0.height.equalTo(13)
       }
       
    }
    
    func SignupButtonTap() {
        secondTextField.rx.text.orEmpty
            .map(checkPassword(_:))
            .subscribe(onNext: { errorMassge in
                switch errorMassge{
                    
                case .over:
                    self.errorMassgeText.isHidden = false
                    self.errorMassgeText.textColor = .red
                    self.errorMassgeText.text = "최소 8글자~ 최대 20글자"
                    
                case .under:
                    self.errorMassgeText.isHidden = false

                    self.errorMassgeText.textColor = .red
                    self.errorMassgeText.text = "최소 8글자~ 최대 20글자"
                    
                case .sign:
                    self.errorMassgeText.isHidden = false
                    self.errorMassgeText.textColor = .blue
                    self.errorMassgeText.text = "대소문자, 숫자, 특수문자"
                    
                case .normal:
                    self.errorMassgeText.isHidden = false
                    self.errorMassgeText.textColor = .blue
                    self.errorMassgeText.text = "사용가능 합니다"
                    let GmailCertificationVC = GmailCertificationViewController()
                    GmailCertificationVC.modalPresentationStyle = .fullScreen
                    self.present(GmailCertificationVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
