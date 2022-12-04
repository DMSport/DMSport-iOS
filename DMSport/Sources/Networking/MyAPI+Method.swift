import Foundation
import Moya

extension MyAPI {
  func getMethod() -> Moya.Method {
    switch self {
    case .postSignUp: return .post
    case .postSignIn: return .post
        
    case .postSignupSend: return .post
    case .postMailAuthentication: return .post
    case .putRefreshToken: return .put
    case .patchChangePassword: return .patch
    case .postFindPasswordMail: return .post
    case .putChangePassword: return .put
    case .deleteLogout: return .delete
    case .deleteMemberGoOut: return .delete
    case .getSearchMyInformation: return .get
    case .postVoteAndrevoke: return .post
    case .getToDayVoteSearch: return .get
    case .getVoteList: return .get
    case .postClubHopeWhether: return .post
    case .getAllSearchNoticeList: return .get
    case .getNoticeDetilSearch: return .get
    case .postNoticeRegistrationAdmin: return .post
    case .postNoticeRegistrationClub: return .post
    case .patchNoticeCorrection: return .patch
    case .deleteNotice: return .delete
    case .getNewlyNotice: return .get
    case .patchStopClub: return .patch
    case .patchChangeOfClub: return .patch
    case .getUserSearchList: return .get
    }
  }
}
