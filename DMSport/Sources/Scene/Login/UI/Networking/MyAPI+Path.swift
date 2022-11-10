import Foundation
import Moya

extension MyAPI {
  func getPath() -> String {
    switch self {
    case .postSignUp:
        return "/api/auth/sign-up"
    case .postSignIn:
        return "/api/auth/sign-in"
        
    case .postSignupSend:
        return "/users/mail/signup"
    case .postMailAuthentication:
        return "/users/mail/verify"
    case .putRefreshToken:
        return "/users/auth"
    case .patchChangePassword:
        return "/users/password"
    case .postFindPasswordMail:
        return "/users/mail/find"
    case .putChangePassword:
        return "/users/password"
    case .deleteLogout:
        return "/users/logout"
    case .deleteMemberGoOut:
        return "/users"
    case .getSearchMyInformation:
        return "/users/my"
    case .postVoteAndrevoke:
        return "/clubs/vote/" //{vote-id}
    case .getToDayVoteSearch:
        return "/clubs/vote"
    case .getVoteList:
        return "/clubs/vote/history"
    case .getClubHopeWhether:
        return "/clubs/schedule/hope"
    case .getAllSearchNoticeList:
        return "/notices"
    case .getNoticeDetilSearch:
        return "/notices/" //{notice-id}
    case .postNoticeRegistrationAdmin:
        return "/notices/admin?type=" //{NOTICE_TYPE}
    case .postNoticeRegistrationClub:
        return "/notices/club"
    case .patchNoticeCorrection:
        return "/notices/" //{notice-id}
    case .deletNotice:
        return "/notices/" //{notice-id}
    case .getNewlyNotice:
        return "/recent"
    case .patchStopClub:
        return "/admin/ban"
    case .patchChangeOfClub:
        return "/admin/manager/" //{user-id}
    case .getUserSearchList:
        return "/admin/users"
    }
  }
}
