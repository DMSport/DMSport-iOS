//
//  MyAPI.swift
//  StudyOfStock
//
//  Created by 박준하 on 2022/10/07.
//

import Foundation
import Moya

enum MyAPI {
    case postSignUp(SignRequest)
    case postSignIn(LoginRequest)
}

// MARK: MyAPI+TargetType
extension MyAPI: Moya.TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var sampleData: Data { Data() }
    var task: Task { self.getTask() }
    var headers: [String : String]? { ["Content-Type": "application/json"] }
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }
}
