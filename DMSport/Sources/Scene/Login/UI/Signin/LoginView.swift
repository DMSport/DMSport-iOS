//
//  MainLoginView.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/19.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginView: BaseSignView {
    
    let loginVM = LoginViewModel()
    
    internal lazy var forgetPassword = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(UIColor(named: "Primary2"), for: .normal)
    }
    
    internal lazy var eyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 13)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }

    internal lazy var loginButton = UIButton().then {
        let image = UIImage(named: "DMSLoginButton")
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    internal lazy var ErrorMassages = UILabel().then {
        $0.text = "에러다에러야!"
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.isHidden = true
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        let image = UIImage(named: "DMSSignButton")
        mainButton.setBackgroundImage(image, for: UIControl.State.normal)
        
        [ forgetPassword, eyeImageButton, loginButton, ErrorMassages]
            .forEach {
                controller.view.addSubview($0)
        }
        
        forgetPassword.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom).offset(30)
            //            $0.height.equalTo(40)
            //            $0.width.equalTo(40)
            $0.centerX.equalTo(controller.view)
        }
        
        eyeImageButton.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom).inset(30)
            $0.trailing.equalTo(secondTextField.snp.trailing).inset(20)
            $0.width.equalTo(28)
            $0.height.equalTo(13)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(mainButton.snp.bottom).inset(110)
            $0.leading.equalTo(mainButton.snp.leading)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        
        ErrorMassages.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom).offset(5)
            $0.leading.equalTo(firstTextField.snp.leading).inset(10)
        }
    }
}
