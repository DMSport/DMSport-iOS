import Foundation
import Moya

extension MyAPI {
  func getPath() -> String {
    switch self {
    case .postSignUp:
        return "/users"
    case .postSignIn:
        return "/users/auth"
        
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
    case .postVoteAndrevoke(let id):
        return "/clubs/vote/\(id)" //{vote-id}
    case .getToDayVoteSearch(_):
        return "/clubs/vote"
    case .getVoteList:
        return "/clubs/vote/history"
    case .postClubHopeWhether:
        return "/clubs/schedule/hope"
    case .getAllSearchNoticeList:
        return "/notices"
    case .getNoticeDetilSearch(let id):
        return "/notices/\(id)" //{notice-id}
    case .postNoticeRegistrationAdmin(_, _, _):
        return "/notices/admin" //{NOTICE_TYPE}
    case .postNoticeRegistrationClub(_, _, _):
        return "/notices/club"
    case .patchNoticeCorrection(_, _, let id):
        return "/notices/\(id)" //{notice-id}
    case .deleteNotice(let id):
        return "/notices/\(id)" //{notice-id}
    case .getNewlyNotice:
        return "notices/recent"
    case .patchStopClub:
        return "/admin/ban"
    case .patchChangeOfClub:
        return "/admin/manager/" //{user-id}
    case .getUserSearchList:
        return "/admin/users"
    }
  }
}
