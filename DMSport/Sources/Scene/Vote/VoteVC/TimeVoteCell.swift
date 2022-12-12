import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class TimeVoteCell: BaseTC {
    let disposeBag = DisposeBag()
    var applied = PublishRelay<Bool>()
    var id = Int()
    var graphWidth = CGFloat()
    
    let backView = UIView().then {
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
    let votedUserButton = UIButton().then {
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.setTitle("신청자 목록 보기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        $0.setTitleColor(DMSportColor.whiteColor.color, for: .normal)
        $0.layer.cornerRadius = 12
    }
    override func addView() {
        addSubview(backView)
        [
            votedUserButton,
            applyButton
        ] .forEach {
            contentView.addSubview($0)
        }
        graphBase.addSubview(graphView)
        [
            categoryLabel,
            lunchDinnerLabel,
            leftMemebersLabel,
            graphBase,
            graphView,
            votedUserButton
        ] .forEach {
            backView.addSubview($0)
        }
    }
    override func configureVC() {
        self.applied.asObservable().subscribe(onNext: { bool in
            if bool == false {
                self.applyButton.backgroundColor = DMSportColor.mainColor.color
                self.applyButton.setTitle("신청", for: .normal)
            } else {
                self.applyButton.backgroundColor = DMSportColor.disabledColor.color
                self.applyButton.setTitle("완료", for: .normal)
            }
        }).disposed(by: self.disposeBag)
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
        }
        graphView.snp.makeConstraints {
            $0.top.equalTo(graphBase.snp.top)
            $0.left.equalTo(graphBase.snp.left)
            $0.bottom.equalTo(graphBase.snp.bottom)
            $0.width.equalTo(graphWidth)
        }
        votedUserButton.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(14)
            $0.top.equalToSuperview().inset(95)
            $0.left.equalToSuperview().inset(18)
            $0.width.equalTo(115)
            $0.height.equalTo(23)
        }
        applyButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(83)
            $0.right.equalToSuperview().inset(10)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
    }
}
