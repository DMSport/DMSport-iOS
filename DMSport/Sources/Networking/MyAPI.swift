import Foundation
import Moya

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
    case postVoteAndrevoke(PostVoteAndRevoke)
    case getToDayVoteSearch(GetToDayVoteSearch)
    case getVoteList(GetVoteList)
    case getClubHopeWhether(GetClubHopeWhether)
    
    //notices
    case getAllSearchNoticeList(GetAllSearchNoticeList)
    case getNoticeDetilSearch(GetNoticeDetilSearch)
    case postNoticeRegistrationAdmin(PostNoticeRegistrationAdmin)
    case postNoticeRegistrationClub(PostNoticeRegistrationClub)
    case patchNoticeCorrection(PatchNoticeCorrection)
    case deleteNotice(DeletNotice)
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

extension Header {
    case
}
