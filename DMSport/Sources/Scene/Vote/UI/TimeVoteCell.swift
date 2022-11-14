import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class TimeVoteCell: BaseTC {
    var applied: Bool = false
    let disposeBag = DisposeBag()
    
    private let backView = UIView().then {
        $0.backgroundColor = DMSportColor.whiteColor.color
        $0.layer.cornerRadius = 20
    }
    let categoryLabel = UILabel().then {
        $0.textColor = DMSportColor.blackColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    let lunchDinnerLabel = UILabel().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .right
    }
    let leftMemebersLabel = UILabel().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textAlignment = .left
    }
    let graphBase = UIView().then {
        $0.backgroundColor = DMSportColor.baseColor.color
        $0.layer.cornerRadius = 4
    }
    let graphView = UIView().then {
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.layer.cornerRadius = 4
    }
    var applyButton = UIButton().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.setTitle("신청", for: .normal)
        $0.setTitleColor(DMSportColor.whiteColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    override func addView() {
        addSubview(backView)
        graphBase.addSubview(graphView)
        [
            categoryLabel,
            lunchDinnerLabel,
            leftMemebersLabel,
            graphBase,
            graphView,
            applyButton
        ] .forEach {
            backView.addSubview($0)
        }
    }
    override func configureVC() {
        self.applyButton.rx.tap
            .subscribe(onNext: {
                if self.applied {
                    self.applyButton.backgroundColor = DMSportColor.mainColor.color
                    self.applyButton.setTitle("신청", for: .normal)
                }
                else {
                    self.applyButton.backgroundColor = DMSportColor.disabledColor.color
                    self.applyButton.setTitle("완료", for: .normal)
                }
                self.applied = !self.applied
            }).disposed(by: disposeBag)
        self.backgroundColor = .clear
    }
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(130)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview().inset(18)
            $0.height.equalTo(22)
        }
        lunchDinnerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(37)
            $0.right.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        leftMemebersLabel.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(16)
        }
        graphBase.snp.makeConstraints {
            $0.top.equalTo(leftMemebersLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(8)
//            $0.bottom.equalToSuperview().inset(56)
        }
        graphView.snp.makeConstraints {
            $0.top.equalTo(graphBase.snp.top)
            $0.left.equalTo(graphBase.snp.left)
            $0.bottom.equalTo(graphBase.snp.bottom)
            $0.width.equalTo(158)
        }
        applyButton.snp.makeConstraints {
            $0.top.equalTo(graphBase.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(10)
            $0.width.equalTo(80)
//            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}