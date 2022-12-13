import Foundation
import Moya
import RxMoya

enum MyAPI {
    //users
    case postSignupSend(PostSignupSendRequest)
    case postMailAuthentication(PostmailAuthenticationRequest)
    case postSignUp(PostSignRequest)
    case postSignIn(PostLoginRequest)
    case putRefreshToken(PutResendRefreshToken)
    case patchChangePassword(PatchChangePassword)
    case postFindPasswordMail(PostFindPasswordMail)
    case putChangePassword(PutChangePassword)
    case deleteLogout(DeletLogout)
    case deleteMemberGoOut(DeletMemberGoOut)
    case getSearchMyInformation(GetSearchMyInFormation)
    
    //clubs
    case postVoteAndrevoke(_voteID: Int)
    case getToDayVoteSearch(_type: String)
    case getVoteList(GetVoteList)
    case postClubHopeWhether(PostClubHopeWhether)
    
    //notices
    case getAllSearchNoticeList
    case getNoticeDetilSearch(_ noticeID: Int)
    case postNoticeRegistrationAdmin(_title: String, _content: String, _type: String)
    case postNoticeRegistrationClub(_title: String, _content: String, _type: String)
    case patchNoticeCorrection(_ title: String, _ content: String, _ noticeID: Int)
    case deleteNotice(_ noticeID: Int)
    case getNewlyNotice
    
    //admin
    case patchStopClub(PatchStopClub)
    case patchChangeOfClub(PatchChangeOfClub)
    case getUserSearchList(GetUserSearchList)
}

// MARK: MyAPI+TargetType
extension MyAPI: Moya.TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var sampleData: Data { Data() }
    var validationType: ValidationType { .successCodes }
    var task: Task { self.getTask() }
//    var headers: [String : String]? { ["Content-Type": "application/json"] }
    var headers: [String : String]? {
        switch self {
        case .patchChangePassword, .deleteLogout, .deleteMemberGoOut, .getSearchMyInformation, .postVoteAndrevoke, .getToDayVoteSearch, .getVoteList, .postClubHopeWhether, .getAllSearchNoticeList, .getNoticeDetilSearch, .postNoticeRegistrationAdmin, .postNoticeRegistrationClub, .patchNoticeCorrection, .deleteNotice, .getNewlyNotice, .patchStopClub, .patchChangeOfClub, .getUserSearchList:
            return Header.accesstoken.header()
        case .putRefreshToken:
            return Header.refreshToken.header()
        case .postSignIn, .postSignUp, .postSignupSend, .postMailAuthentication, .postFindPasswordMail, .putChangePassword:
            return Header.tokenIsEmpty.header()
        }
    }
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
