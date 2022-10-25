//
//  LoginConfigure.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/19.
//  Copyright © 2022 com.DMS. All rights reserved.
//

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
                self.errorMassgeText.textColor = error ? .blue : .red
                self.secondTextField.layer.borderColor = error ? UIColor.blue.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
//        [
//            firstTextField.rx.text.orEmpty.map(checkEmail(_:)),
//            secondTextField.rx.text.orEmpty.map(checkPassword(_:))
//        ].forEach {
//            $0.subscribe(onNext: { errorMassge in
//                self.ErrorMassages.isHidden = false
//                self.errorImage.isHidden = false
//                self.ErrorMassages.textColor = errorMassge == .chek ? .blue : .red
//                self.firstTextField.layer.borderColor = errorMassge == .chek ? UIColor.blue.cgColor : UIColor.red.cgColor
//            })
//            .disposed(by: disposeBag)
//        }
    }
    
    
    @objc func signupButtonTap(_ sender: UIButton!,_ controller: UIViewController){
        print("☺️ 회원가입 드가자")
        let signupVC = SignUpViewController()
        signupVC.modalPresentationStyle = .fullScreen
        controller.present(signupVC, animated: true)
    }
    
    @objc func nextButtonTap(){
        print("🥸 비밀번호를 잊어버렸어요")
    }
}
