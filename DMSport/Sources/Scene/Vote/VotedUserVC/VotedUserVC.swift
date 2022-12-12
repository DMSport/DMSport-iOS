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
    let teamTableView = UITableView().then {
        $0.register(VotedUserCell.self, forCellReuseIdentifier: "Users")
        $0.allowsSelection = false
    }
    private func bindData() {
        userList.bind(to: teamTableView.rx.items(
            cellIdentifier: "Users",
            cellType: VotedUserCell.self)) { row, items, cell in
                cell.userLabel.text = items.name
            }.disposed(by: disposeBag)
    }
    override func addView() {
        [
            guideLabel,
            teamTableView
        ] .forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
        bindData()
    }
    override func setLayout() {
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
        teamTableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}
