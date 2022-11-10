import Foundation

struct PostSignupSendRequest: ModelType {
    var email: String
}

struct PostmailAuthenticationRequest: ModelType {
    let email, authCode: String

    enum CodingKeys: String, CodingKey {
        case email
        case authCode = "auth_code"
    }
}

struct PostSignRequest: ModelType {
    var email: String
    var password: String
    var name: String
}

struct PostLoginRequest: ModelType {
    var email: String
    var password: String
}

struct PutResendRefreshToken: ModelType {
    //put
    var access_token: String
    var expired_at: String
    var refresh_token: String
}

struct PatchChangePassword: ModelType {
    var old_password: String
    var new_password: String
}

struct PostFindPasswordMail: ModelType {
    var email: String
}

struct PutChangePassword: ModelType {
    var email: String
    var new_password: String
}

struct DeletLogout: ModelType {
    
}

struct DeletMemberGoOut: ModelType {
    var password: String
}

struct GetSearchMyInFormation: ModelType {
    var name: String
    var email: String
    var authority: String
}

struct PostVoteAndRevoke: ModelType {
    
}

struct GetToDayVoteSearch: Codable {
    let isBan: Bool
    let banPeriod: String
    let maxPeople: Int
    let vote: [Vote]

    enum CodingKeys: String, CodingKey {
        case isBan = "is_ban"
        case banPeriod = "ban_period"
        case maxPeople = "max_people"
        case vote
    }
}

// MARK: - Vote
struct Vote: Codable {
    let voteID: Int
    let time: String
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case voteID = "vote_id"
        case time
        case voteCount = "vote_count"
    }
}

struct GetVoteList: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let voteDate: String
    let voteList: [VoteList]

    enum CodingKeys: String, CodingKey {
        case voteDate = "vote_date"
        case voteList = "vote_list"
    }
}

// MARK: - VoteList
struct VoteList: Codable {
    let voteID: Int
    let time: String
    let voteCount, maxPeople: Int

    enum CodingKeys: String, CodingKey {
        case voteID = "vote_id"
        case time
        case voteCount = "vote_count"
        case maxPeople = "max_people"
    }
}

struct GetClubHopeWhether: ModelType {
    
}

struct GetAllSearchNoticeList: Codable {
    let notices: [Notice]
}

// MARK: - Notice
struct Notice: Codable {
    let id: Int
    let type, title, contentPreview, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, type, title
        case contentPreview = "content_preview"
        case createdAt = "created_at"
    }
}

struct GetNoticeDetilSearch: Codable {
    let type, title, content, writer: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case type, title, content, writer
        case createdAt = "created_at"
    }
}

struct PostNoticeRegistrationAdmin: ModelType {
    var title: String
    var content: String
}

struct PostNoticeRegistrationClub: ModelType {
    var title: String
    var content: String
}

struct PatchNoticeCorrection: ModelType {
    var title: String
    var content: String
}

struct DeletNotice: ModelType {
    
}

struct GetNewlyNotice: Codable {
    let manager, admin: [Admin]
}

// MARK: - Admin
struct Admin: Codable {
    let id: Int
    let title, contentPreview, type, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case contentPreview = "content_preview"
        case type
        case createdAt = "created_at"
    }
}

struct PatchStopClub: Codable {
    let clubName, banPeriod: String

    enum CodingKeys: String, CodingKey {
        case clubName = "club_name"
        case banPeriod = "ban_period"
    }
}

struct PatchChangeOfClub: ModelType {
    let clubType: String

    enum CodingKeys: String, CodingKey {
        case clubType = "club_type"
    }
}

struct GetUserSearchListElement: Codable {
    let id: Int
    let name, authority: String
}

typealias GetUserSearchList = [GetUserSearchListElement]
