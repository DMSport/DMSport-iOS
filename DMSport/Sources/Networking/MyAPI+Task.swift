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
        case .postSignupSend(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .postMailAuthentication(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .putRefreshToken(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .patchChangePassword(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .postFindPasswordMail(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .putChangePassword(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .deleteLogout(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .deleteMemberGoOut(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .getSearchMyInformation(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .postVoteAndrevoke:
            return .requestPlain
        case .getToDayVoteSearch(let type):
            return .requestParameters(
                parameters:
                    [
                        "type" : type
                    ],
                encoding: URLEncoding.queryString)
        case .getVoteList(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .postClubHopeWhether(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .getAllSearchNoticeList:
            return .requestPlain
        case .getNoticeDetilSearch:
            return .requestPlain
        case .postNoticeRegistrationAdmin(let title, let content, let type):
            return .requestCompositeParameters(
                bodyParameters:
                    [
                        "title" : title,
                        "content" : content
                    ],
                bodyEncoding: JSONEncoding.default,
                urlParameters:
                    [
                        "type" : type
                    ]
            )
        case .postNoticeRegistrationClub(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .patchNoticeCorrection(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .deleteNotice(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .getNewlyNotice:
            return .requestPlain
        case .patchStopClub(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .patchChangeOfClub(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        case .getUserSearchList(let body):
            return .requestParameters(
                parameters: body.toDictionary(),
                encoding: JSONEncoding.default
            )
        }
    }
}
