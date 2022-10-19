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
