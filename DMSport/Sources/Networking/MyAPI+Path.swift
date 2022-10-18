//
//  MyAPI+Path.swift
//  StudyOfStock
//
//  Created by 박준하 on 2022/10/07.
//

import Foundation
import Moya

extension MyAPI {
  func getPath() -> String {
    switch self {
    case .postSignUp:
        return "/users"
    case .postSignIn:
        return "/users/auth"
        
    }
  }
}
