import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class NoticeBottomSheetVC: BaseVC {
    private let viewModel = NoticeDeleteVM()
    var noticeId = Int()
    private let guideLabel = UILabel().then {
            $0.text = "수정/삭제 하시겠습니까?"
            $0.textColor = DMSportColor.hintColor.color
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textAlignment = .center
        }
    private let cancelButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .clear
        $0.setTitle("취소하기", for: .normal)
        $0.setTitleColor(DMSportColor.hintColor.color, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18.48, weight: .bold)
    }
    private let editButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(DMSportColor.whiteColor.color, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18.48, weight: .bold)
    }
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제하기 ", for: .normal)
        $0.setTitleColor(DMSportColor.highlightColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.tintColor = DMSportColor.highlightColor.color
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
    }
    private func deleteNotice() {
        let input = NoticeDeleteVM.Input(
            noticeID: noticeId,
            buttonDidTap: deleteButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: { bool in
            if bool == true {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        if #available(iOS 16.0, *) {
            if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.detents = [
                    .custom { _ in
                        return 130
                    }
                ]
                presentationController.preferredCornerRadius = 20
            }
        } else { /*Fallback on earlier versions*/ }
        [
            guideLabel,
            deleteButton,
            cancelButton,
            editButton
        ] .forEach {
            view.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
        deleteButton.rx.tap
            .subscribe(onNext: {
                print("will be deleted")
                self.deleteNotice()
            }).disposed(by: disposeBag)
        cancelButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    override func setLayout() {
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.right.equalToSuperview().inset(30)
            $0.height.equalTo(20)
        }
        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            if view.frame.width < 400 {
                $0.width.equalTo(164)
            } else {
                $0.width.equalTo(184)
            }
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(40)
        }
        editButton.snp.makeConstraints {            $0.leading.equalTo(cancelButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
