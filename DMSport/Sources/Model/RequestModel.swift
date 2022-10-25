//
//  Model.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/18.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation

struct SignRequest: ModelType {
    var email: String
    var password: String
    var name: String
}

struct LoginRequest: ModelType {
    var email: String
    var password: String
}
