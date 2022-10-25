//
//  LoginModel.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/20.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation

class LoginModel {
    
    var email = ""
    var password = ""
    
    init(email : String, password: String) {
        self.email = email
        self.password = password
    }
}
