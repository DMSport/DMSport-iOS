//
//  StartInheritanceViewController.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/17.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import Then

class TestMomViewController: UIViewController {
    
    let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("안녕!")
        view.backgroundColor = .systemBackground
        fristTextField.layer.cornerRadius = 20
        fristTextField.layer.borderWidth = 0.5
        fristTextField.layer.borderColor = UIColor.black.cgColor
        secondTextField.layer.cornerRadius = 20
        secondTextField.layer.borderWidth = 0.5
        secondTextField.layer.borderColor = UIColor.black.cgColor
        fristTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        secondTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        fristTextField.leftViewMode = .always
        secondTextField.leftViewMode = .always
        setupLayout()
    }
    
    internal lazy var fristText = UILabel().then {
        $0.textColor = UIColor(named: "Primary")
        $0.font = .systemFont(ofSize: 58.0, weight: .bold)
        $0.text = "로그인"
        
    }
    
    internal lazy var logoText = UILabel().then {
        $0.textColor = UIColor(named: "Primary2")
        $0.font = .systemFont(ofSize: 35.0, weight: .bold)
        $0.text = "DMSport."
    }
    
    internal lazy var fristTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }


    
    internal lazy var secondTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    public lazy var signupButton = UIButton().then {
        $0.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
}


extension TestMomViewController {
    
    @objc func setupLayout() {
        [
            fristText,
            logoText,
            fristTextField,
            secondTextField,
            signupButton
        ].forEach { view.addSubview($0) }
                
        fristText.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(160)
            $0.leading.equalToSuperview().offset(25)
        }
        
        logoText.snp.makeConstraints {
            $0.top.equalTo(fristText.snp.bottom)
            $0.leading.equalTo(fristText.snp.leading)
        }
        
        fristTextField.snp.makeConstraints {
            $0.top.equalTo(logoText.snp.bottom).offset(42)
            $0.centerX.equalTo(view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        secondTextField.snp.makeConstraints {
            $0.top.equalTo(fristTextField.snp.bottom).offset(32)
            $0.centerX.equalTo(view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }

        signupButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(25)
            $0.centerX.equalTo(view)
            $0.height.equalTo(secondTextField.snp.height)
            $0.width.equalTo(secondTextField.snp.width)
        }
    }
    
    @objc func loginButtonTap(_ sender: UIButton!){
        print("🫶 로그인 드가자")
        
    }
            
    @objc func signupButtonTap(_ sender: UIButton!){
        print("☺️ 회원가입 드가자")
        let signupVC = MainSignUpViewController()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true)
    }
}
