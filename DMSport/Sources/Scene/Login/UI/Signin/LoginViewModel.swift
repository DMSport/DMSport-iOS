//
//  LoginViewModel.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/20.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel {
    
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var errorMsg = BehaviorRelay<String>(value: "")
    var errorMsg2 = BehaviorRelay<String>(value: "")
    
    let emailRegex = NSPredicate(format:"SELF MATCHES %@", "^^[a-zA-Z0-9]+@dsm.hs.kr$$")
    let passwordRegex = NSPredicate(format:"SELF MATCHES %@", "^^(.+){8,21}$$")
    
    func validationEmail() -> Bool {
        if email.value.isEmpty {
            errorMsg.accept("이메일을 입력해 주세요")
            return false
        } else if !emailRegex.evaluate(with: email.value) {
            errorMsg.accept("올바른 이메일을 입력해 주세요")
            return false
        }
        
        errorMsg.accept("사용 가능한 이메일입니다")
        
        return true
    }
    
    func validationPassword() -> Bool {
        if password.value.isEmpty {
            errorMsg2.accept("비밀번호를 입력해 주세요")
            return false
        } else if !passwordRegex.evaluate(with: password.value) {
            errorMsg2.accept("올바른 비밀번호를 입력해 주세요")
            return false
        }
        errorMsg2.accept("사용 가능한 비밀번호입니다")
        
        return true
    }
}
