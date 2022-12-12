import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Moya
import RxMoya

class NoticeEditAlertVC: BaseVC {
    private let mainProvider = MoyaProvider<MyAPI>()
    private let postNotices = BehaviorRelay<Void>(value: ())
    let viewModel = NewNoticeAlertVM()
    
    private let popupView = UIView().then {
        $0.backgroundColor = DMSportColor.baseColor.color
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let alertTitle = UILabel().then {
        $0.text = "공지 제목"
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    let noticeIDLabel = UILabel().then {
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 10, weight: .regular)
    }
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(DMSportColor.highlightColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        let state = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular, scale: .default)
        let trashImage = UIImage(systemName: "trash", withConfiguration: state)
        $0.setImage(trashImage, for: .normal)
        $0.tintColor = DMSportColor.highlightColor.color
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: -0.5, left: 5, bottom: 0, right: 0)
    }
    let noticeTitleTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.layer.cornerRadius = 20
        $0.addPaddingToTextField()
    }
    private let alertContent = UILabel().then {
        $0.text = "공지 내용"
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    let noticeContentTextView = UITextView().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.layer.cornerRadius = 20
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    private let cancelButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(DMSportColor.hintColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    private let completeButton = UIButton().then {
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(DMSportColor.whiteColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.layer.cornerRadius = 20
    }
    
    private func deleteDidTap() {
        let deleteViewModel = NoticeDeleteVM()
        let input = NoticeDeleteVM.Input(
            noticeID: Int("\(noticeIDLabel.text ?? "")") ?? 0,
            buttonDidTap: deleteButton.rx.tap.asSignal())
        let output = deleteViewModel.transform(input)
        output.result
            .subscribe(onNext: { bool in
            if bool {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    private func editDidTap() {
        let patchViewModel = NoticePatchVM()
        let input = NoticePatchVM.Input(
            newTitle: noticeTitleTextField.text ?? "",
            newContent: noticeContentTextView.text,
            noticeID: Int("\(noticeIDLabel.text ?? "")") ?? 0,
            buttonDidTap: completeButton.rx.tap.asSignal())
        let output = patchViewModel.transform(input)
        output.result
            .subscribe(onNext: { bool in
            if bool {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubview(popupView)
        [
            alertTitle,
            noticeIDLabel,
            deleteButton,
            noticeTitleTextField,
            alertContent,
            noticeContentTextView,
            completeButton,
            cancelButton
        ] .forEach {
            popupView.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        deleteButton.rx.tap
            .subscribe(onNext: {
                self.deleteDidTap()
            }).disposed(by: disposeBag)
        completeButton.rx.tap
            .subscribe(onNext: {
                self.editDidTap()
            }).disposed(by: disposeBag)
        cancelButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(370)
            $0.center.equalToSuperview()
        }
        alertTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
        noticeIDLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(18)
            $0.left.equalTo(alertTitle.snp.right).offset(20)
        }
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(25)
            $0.height.equalTo(18)
        }
        noticeTitleTextField.snp.makeConstraints {
            $0.top.equalTo(alertTitle.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(14.69)
            $0.height.equalTo(48)
        }
        alertContent.snp.makeConstraints {
            $0.top.equalTo(noticeTitleTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
        noticeContentTextView.snp.makeConstraints {
            $0.top.equalTo(alertContent.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(14.69)
            $0.bottom.equalToSuperview().inset(64)
        }
        completeButton.snp.makeConstraints {
            $0.width.equalTo(73.44)
            $0.height.equalTo(40)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(73.44)
            $0.height.equalTo(40)
            $0.right.equalTo(completeButton.snp.left).offset(0)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
