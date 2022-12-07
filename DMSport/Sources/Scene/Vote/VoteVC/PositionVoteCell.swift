import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class PositionVoteCell: BaseTC {
    private let backView = UIView().then {
        $0.backgroundColor = DMSportColor.whiteColor.color
        $0.layer.cornerRadius = 20
    }
    let positionLabel =  UILabel().then {
        $0.textColor = DMSportColor.blackColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    let applyButton = UIButton().then {
        $0.setTitle("신청", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(DMSportColor.whiteColor.color, for: .normal)
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.layer.cornerRadius = 20
    }
    override func addView() {
        contentView.addSubview(backView)
        [
            positionLabel,
            applyButton
        ] .forEach {
            backView.addSubview($0)
        }
    }
    override func configureVC() {
        backgroundColor = DMSportColor.baseColor.color
    }
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(56)
        }
        positionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
            $0.left.equalToSuperview().inset(20)
        }
        applyButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(10)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
    }
}
