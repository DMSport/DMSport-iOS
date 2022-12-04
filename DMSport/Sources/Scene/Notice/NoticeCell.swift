import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class NoticeCell: BaseTC {
    var id: Int = 0
    
    private let backView = UIView().then {
        $0.backgroundColor = DMSportColor.whiteColor.color
        $0.layer.cornerRadius = 20
    }
    let noticeTitle =  UILabel().then {
        $0.textColor = DMSportColor.blackColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    let noticeDetails = UILabel().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    let ellipsisButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = DMSportColor.hintColor.color
        $0.transform = CGAffineTransform(rotationAngle: .pi * 0.5)
    }
    let noticeContent = UITextView().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .justified
    }
    override func addView() {
        addSubview(backView)
        [
            noticeTitle,
            noticeDetails,
            ellipsisButton,
            noticeContent
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
            $0.height.equalTo(133)
        }
        noticeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.height.equalTo(22)
            $0.left.equalToSuperview().inset(18)
        }
        noticeDetails.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalTo(noticeTitle.snp.right).offset(10)
        }
        ellipsisButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.bottom.equalTo(noticeContent.snp.top).offset(10)
            $0.right.equalToSuperview().inset(19)
        }
        noticeContent.snp.makeConstraints {
            $0.top.equalTo(noticeTitle.snp.bottom).offset(0)
            $0.left.right.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
