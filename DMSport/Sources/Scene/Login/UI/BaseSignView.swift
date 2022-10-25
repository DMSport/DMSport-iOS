//
//  BaseSignView.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/19.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class BaseSignView {
    
    let disposeBag = DisposeBag()
    
    internal lazy var firstText = UILabel().then {
        $0.textColor = UIColor(named: "Primary")
        $0.font = .systemFont(ofSize: 58.0, weight: .bold)
        $0.text = "로그인"
    }
    
    internal lazy var logoText = UILabel().then {
        $0.textColor = UIColor(named: "Primary2")
        $0.font = .systemFont(ofSize: 35.0, weight: .bold)
        $0.text = "DMSport."
    }
    
    internal lazy var firstTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
    }
        
    internal lazy var secondTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    public lazy var mainButton = UIButton().then {
        $0.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
    }
    
    internal lazy var errorMassgeText = UILabel().then {
        $0.text = "에러다에러야!"
        $0.font = .systemFont(ofSize: 10.0, weight: .semibold)
        $0.isHidden = true
    }
    
    internal lazy var errorImage = UIImageView().then {
        let imageName = "errorImage"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        $0.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        $0.backgroundColor = .red
        $0.isHidden = true
    }
    
    func updateWith(_ controller: UIViewController) {
        [
            firstText,
            logoText,
            firstTextField,
            secondTextField,
            mainButton,
            errorMassgeText,
            errorImage
        ].forEach { controller.view.addSubview($0) }
        
        firstText.snp.makeConstraints {
            $0.top.equalTo(controller.view.safeAreaLayoutGuide).inset(160)
            $0.leading.equalToSuperview().offset(25)
        }
        
        logoText.snp.makeConstraints {
            $0.top.equalTo(firstText.snp.bottom)
            $0.leading.equalTo(firstText.snp.leading)
        }
        
        firstTextField.snp.makeConstraints {
            $0.top.equalTo(logoText.snp.bottom).offset(42)
            $0.centerX.equalTo(controller.view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        
        secondTextField.snp.makeConstraints {
            $0.top.equalTo(firstTextField.snp.bottom).offset(32)
            $0.centerX.equalTo(controller.view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }

        mainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalTo(controller.view)
            $0.height.equalTo(secondTextField.snp.height)
            $0.width.equalTo(secondTextField.snp.width)
        }
        
        errorMassgeText.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom).offset(5)
            $0.leading.equalTo(secondTextField.snp.leading).inset(10)
        }
        
        errorImage.snp.makeConstraints {
            $0.top.equalTo(secondTextField.snp.bottom).inset(38)
            $0.trailing.equalToSuperview().inset(80)
            $0.width.equalTo(25)
            $0.height.equalTo(25)
        }
    }
}
