import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Moya
import RxMoya

class VotedUserAlertVC: BaseVC {
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
    let menuButton = UIButton().then {
        $0.setTitle("종목", for: .normal)
        $0.setTitleColor(DMSportColor.hintColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        $0.setImage(UIImage(named: "Menu"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
    }
//    private func postNewNotice() {
//        let input = NewNoticeAlertVM.Input(
//            newTitle: noticeTitleTextField.rx.text.orEmpty.asDriver(onErrorJustReturn: ""),
//            newContent: noticeContentTextView.rx.text.orEmpty.asDriver(onErrorJustReturn: ""),
//            category: menuButton.menu?.children.,
//            buttonDidTap: completeButton.rx.tap.asSignal())
//        let output = viewModel.transform(input)
//        output.result.subscribe(onNext: { bool in
//            if bool == true {
//                self.dismiss(animated: true)
//            }
//        }).disposed(by: disposeBag)
//    }
    
    private func setButtonMenu() {
        print("menu")
        
        let all = UIAction(title: "전체", handler: { _ in print("전체") })
        let badminton = UIAction(title: "배드민턴", handler: { _ in print("배드민턴") })
        let soccer = UIAction(title: "축구", handler: { _ in print("축구") })
        let basketball = UIAction(title: "농구", handler: { _ in print("농구") })
        let volleyball = UIAction(title: "배구", handler: { _ in print("배구") })
        
        menuButton.menu = UIMenu(
            identifier: nil,
            options: .displayInline,
            children:
                [
                    all,
                    badminton,
                    soccer,
                    basketball,
                    volleyball
                ])
    }
    override func addView() {
        view.addSubview(popupView)
        [
            alertTitle,
            menuButton,
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
        setButtonMenu()
        cancelButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
//        completeButton.rx.tap
//            .subscribe(onNext: {
//                self.postNewNotice()
//            }).disposed(by: disposeBag)
    }
    override func setLayout() {
        popupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(368)
            $0.center.equalToSuperview()
        }
        alertTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(22.46)
            $0.height.equalTo(24)
        }
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(30)
            $0.height.equalTo(17)
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
            $0.right.equalToSuperview().inset(7.34)
            $0.bottom.equalToSuperview().inset(8)
        }
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(73.44)
            $0.height.equalTo(40)
            $0.right.equalTo(completeButton.snp.left).offset(9)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
