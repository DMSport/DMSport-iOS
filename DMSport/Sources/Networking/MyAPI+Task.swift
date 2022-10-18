//
//  MyAPI+Task.swift
//  StudyOfStock
//
//  Created by 박준하 on 2022/10/07.
//

import Foundation
import Moya

extension MyAPI {
    func getTask() -> Task {
        switch self {
        case .postSignIn(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .postSignUp(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        }
    }
}
