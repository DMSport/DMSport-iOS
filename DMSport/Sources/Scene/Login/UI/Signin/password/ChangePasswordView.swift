//
//  ChangePasswordView.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/11/11.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit

class ChangePasswordView: BaseSignView {
    
    internal lazy var firstEyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 13)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    internal lazy var secondEyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 13)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    internal lazy var ErrorMassages = UILabel().then {
        $0.text = "에러다에러야!"
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.isHidden = true
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        let image = UIImage(named: "okButton")
        mainButton.setBackgroundImage(image, for: UIControl.State.normal)
        firstText.text = "변경하기"
        logoText.text = "Password"
        firstTextField.placeholder = "새로운 비밀번호를 입력해 주세요"
        secondTextField.placeholder = "비밀번호를 다시 입력해 주세요"
        firstTextField.isSecureTextEntry = true
        
        [firstEyeImageButton, ErrorMassages, secondEyeImageButton]
            .forEach {
                controller.view.addSubview($0)
        }
        
        firstEyeImageButton.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom).inset(30)
            $0.trailing.equalTo(secondTextField.snp.trailing).inset(20)
            $0.width.equalTo(28)
            $0.height.equalTo(13)
        }
        
        secondEyeImageButton.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom).inset(30)
            $0.trailing.equalTo(firstTextField.snp.trailing).inset(20)
            $0.width.equalTo(28)
            $0.height.equalTo(13)
        }
        
        ErrorMassages.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom).offset(5)
            $0.leading.equalTo(firstTextField.snp.leading).inset(10)
        }
    }
}
