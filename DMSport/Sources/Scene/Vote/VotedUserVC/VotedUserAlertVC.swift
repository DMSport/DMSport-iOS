import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class VotedUserAlertVC: BaseVC {
    var noticeId = Int()
    var userList = PublishRelay<[User]>()
    
    private let popupView = UIView().then {
        $0.backgroundColor = DMSportColor.baseColor.color
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let guideLabel = UILabel().then {
        $0.text = "신청자 목록"
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
    }
    let teamTableView = UITableView().then {
        $0.register(VotedUserCell.self, forCellReuseIdentifier: "Users")
        $0.backgroundColor = .clear
        $0.allowsSelection = false
        $0.separatorStyle = .none
    }
    private let cancelButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("닫기", for: .normal)
        $0.setTitleColor(DMSportColor.hintColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    private func bindData() {
        userList.bind(to: teamTableView.rx.items(
            cellIdentifier: "Users",
            cellType: VotedUserCell.self)) { row, items, cell in
                cell.userLabel.text = items.name
            }.disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubview(popupView)
        [
            guideLabel,
            teamTableView,
            cancelButton
        ] .forEach {
            popupView.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        bindData()
        cancelButton.rx.tap
            .bind {
                self.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(370)
            $0.center.equalToSuperview()
        }
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
        teamTableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(60)
        }
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(73.44)
            $0.height.equalTo(40)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
