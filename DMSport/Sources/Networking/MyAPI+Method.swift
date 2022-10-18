//
//  MyAPI+Method.swift
//  StudyOfStock
//
//  Created by 박준하 on 2022/10/07.
//

import Foundation
import Moya

extension MyAPI {
  func getMethod() -> Moya.Method {
    switch self {
    case .postSignUp: return .post
    case .postSignIn: return .post
        
    }
  }
}
