//
//  LoginConfigure.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/19.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
import UIKit
import RxRelay

extension LoginView {
    
    enum IdRange {
        case over
        case under
        case sign
        case normal
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
        
//        return .sign
        return .normal
    }

    func LoginButtonTap(_ controller: UIViewController) {
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
//                    let GmailCertificationVC = GmailCertificationViewController()
//                    GmailCertificationVC.modalPresentationStyle = .fullScreen
//                    controller.present(GmailCertificationVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
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
    
    
    //viewModal로 보내기
//    
//    let emailObservar = BehaviorRelay<String>(value: "")
//    let passwordObservar = BehaviorRelay<String>(value: "")
    
    //    var isValid: Observable<Bool> {
    //        return Observable.combineLatest(emailObservar, passwordObservar)
    //            .map { email, password in
    //                print("📬email: \(email), 🔒password: \(password)")
    //                return !email.isEmpty && email.contains("@") && email.contains(".") && !password.isEmpty && password.count > 0
    //            }
    //    }
    
    //------------
}
