//
//  MainLoginVC.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/17.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import Then
import RxRelay

class MainLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "DMSSignButton")
        signupButton.setBackgroundImage(image, for: UIControl.State.normal)
        signupButton.addTarget(self, action: #selector(signupButtonTap), for: .touchUpInside)
        setupLayout()
    }
    
    //viewModal로 보내기
    
    let emailObservar = BehaviorRelay<String>(value: "")
    let passwordObservar = BehaviorRelay<String>(value: "")
    
    //    var isValid: Observable<Bool> {
    //        return Observable.combineLatest(emailObservar, passwordObservar)
    //            .map { email, password in
    //                print("📬email: \(email), 🔒password: \(password)")
    //                return !email.isEmpty && email.contains("@") && email.contains(".") && !password.isEmpty && password.count > 0
    //            }
    //    }
    
    //------------
    
    private lazy var loginText = UILabel().then {
        $0.textColor = UIColor(named: "Primary")
        $0.font = .systemFont(ofSize: 58.0, weight: .bold)
        $0.text = "로그인"
    }
    
    private lazy var emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    private lazy var forgetPassword = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(UIColor(named: "Primary2"), for: .normal)
    }
    
    private lazy var loginButton = UIButton().then {
        let image = UIImage(named: "DMSLoginButton")
        $0.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
        $0.addTarget(self, action:#selector(loginButtonTap), for: .touchUpInside)
    }
    
    internal lazy var eyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
}
extension MainLoginViewController {
    
    override func setupLayout() {
        [
            loginText,
            logoText,
            emailTextField,
            passwordTextField,
            forgetPassword,
            
            signupButton,
            loginButton,
            
            eyeImageButton
            
        ].forEach { view.addSubview($0) }
        
//                let width = view.frame.width / 430
//                let height = view.frame.height / 932
        
        loginText.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(160)
            $0.leading.equalToSuperview().offset(25)
        }
        
        logoText.snp.makeConstraints {
            $0.top.equalTo(loginText.snp.bottom)
            $0.leading.equalTo(loginText.snp.leading)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(logoText.snp.bottom).offset(42)
            $0.centerX.equalTo(view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(32)
            $0.centerX.equalTo(view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        
        forgetPassword.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            //            $0.height.equalTo(40)
            //            $0.width.equalTo(40)
            $0.centerX.equalTo(view)
        }
        
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(forgetPassword.snp.bottom).offset(180)
            $0.centerX.equalTo(view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(12)
            $0.centerX.equalTo(view)
            $0.height.equalTo(loginButton.snp.height)
            $0.width.equalTo(loginButton.snp.width)
        }
        
        eyeImageButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(52)
            $0.trailing.equalToSuperview().inset(40)
            $0.width.equalTo(28)
            $0.height.equalTo(13)
        }
    }
    
    
    @objc func nextButtonTap(_ sender: UIButton!){
        print("🥸 비밀번호를 잊어버렸어요")
    }
    
    
}
