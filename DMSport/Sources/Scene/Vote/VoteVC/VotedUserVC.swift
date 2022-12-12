import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class VotedUserVC: BaseVC {
    var noticeId = Int()
    var userList = PublishRelay<[User]>()
    private let guideLabel = UILabel().then {
        $0.text = "신청자 목록"
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
    }
    private let team1Label = UILabel().then {
        $0.text = "1팀"
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    let team1TableView = UITableView().then {
        $0.allowsSelection = false
    }
    private let team2Label = UILabel().then {
        $0.text = "2팀"
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    let team2TableView = UITableView().then {
        $0.allowsSelection = false
    }
    override func addView() {
        [
            guideLabel
        ] .forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
    }
    override func setLayout() {
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
    }
}
