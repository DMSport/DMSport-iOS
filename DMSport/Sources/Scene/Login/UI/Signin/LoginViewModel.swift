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
    
    func validation() -> Bool {
        
        if email.value.isEmpty {
            errorMsg.accept("Please enter email")
            return false
        } else if !(validateEmail()) {
            errorMsg.accept("Please enter valid email")
            return false
        } else if password.value.isEmpty {
            errorMsg.accept("Please enter password")
            return false
        }
        
        return true
    }
    
    func validateEmail() -> Bool {
        
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email.value)
    }
    
    func callLoginAPI() {
        
        let loginModel = LoginModel(email: email.value, password: password.value)
        print(loginModel.email, loginModel.password)
    }
    
}
