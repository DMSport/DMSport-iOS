//
//  SignupConfigure.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/19.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension SignupView {
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
    
    func SignupButtonTap(_ controller: UIViewController) {
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
                    controller.present(GmailCertificationVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
