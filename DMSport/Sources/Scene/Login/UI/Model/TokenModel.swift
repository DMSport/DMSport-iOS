import Foundation

struct TokenModel: Codable {
    let access_token: String
    let expired_at: String
    let refresh_token: String
    let authority: String
    
//    
//    enum CodingKeys : String, CodingKey{
//        case access_token = "access_token"
//        case expired_at = "refresh_token"
//        case resfresh_token = "refresh_token"
//        case authority = "refresh_token"
//    }
}

