import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class VotedUserCell: BaseTC {
    private let backView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
    }
    let userLabel =  UILabel().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    override func addView() {
        addSubview(backView)
        backView.addSubview(userLabel)
    }
    override func configureVC() {
        backgroundColor = DMSportColor.baseColor.color
    }
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(31)
        }
        userLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.left.equalToSuperview().inset(3)
        }
    }
}
