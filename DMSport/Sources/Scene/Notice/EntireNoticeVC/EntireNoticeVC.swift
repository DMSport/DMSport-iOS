import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya
import RxMoya

class EntireNoticeVC: BaseVC {
    private let mainProvider = MoyaProvider<MyAPI>()
    private let getNotices = BehaviorRelay<Void>(value: ())
    let viewModel = AllNoticeVM()
    var entireNoticeCount: Int = 0
    var noticeID = Int()
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let entireGuideLabel = UILabel().then {
        $0.text = "전체 공지사항"
        $0.textColor = DMSportColor.hintColor.color
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    let entireNoticeTableView = ContentWrappingTableView().then {
        $0.register(NoticeCell.self, forCellReuseIdentifier: "EntireNotice")
        $0.rowHeight =  145
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    private let newNoticeButton = UIButton().then {
        $0.tintColor = DMSportColor.whiteColor.color
        $0.setImage(UIImage(named: "NewPost"), for: .normal)
        $0.backgroundColor = DMSportColor.mainColor.color
        $0.layer.cornerRadius = 26
    }
    private func bindViewModels() {
        let input = AllNoticeVM.Input(
            getNotices: getNotices.asDriver(),
            loadDetail: entireNoticeTableView.rx.itemSelected.asSignal())
        let output = viewModel.transfrom(input)
        
        output.allNotices.bind(to: entireNoticeTableView.rx.items(
            cellIdentifier: "EntireNotice",
            cellType: NoticeCell.self)) { row, items, cell in
                if items.type == "ALL" {
                    cell.noticeTitle.text = items.title
                    cell.noticeDetails.text = items.createdAt
                    cell.noticeContent.text = items.contentPreview
                    self.entireNoticeCount += 1
                    cell.selectionStyle = .none
                } else {
                    print(items.type)
                    cell.selectionStyle = .none
                }
            }.disposed(by: disposeBag)
        output.detailIndex.asObservable()
            .subscribe(onNext: { id in
                let nextVC = NoticeDetailVC()
                nextVC.id = id
                self.navigationController?.pushViewController(nextVC, animated: true)
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            scrollView,
            newNoticeButton
        ] .forEach {
            view.addSubview($0)
        }
        scrollView.addSubview(contentView)
        [
            entireGuideLabel,
            entireNoticeTableView
            
        ] .forEach {
            contentView.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
        scrollView.contentInsetAdjustmentBehavior = .never
        bindViewModels()
        newNoticeButton.rx.tap
            .subscribe(onNext: {
                let newNotice = NewNoticeAlertVC()
                newNotice.modalPresentationStyle = .overFullScreen
                newNotice.modalTransitionStyle = .crossDissolve
                self.present(newNotice, animated: true)
            }).disposed(by: disposeBag)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            if entireNoticeCount * 133 > 800 {
                $0.height.equalTo(200 + entireNoticeCount * 133)
            } else {
                $0.height.equalTo(900)
            }
        }
        entireGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        entireNoticeTableView.snp.makeConstraints {
            $0.top.equalTo(entireGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        newNoticeButton.snp.makeConstraints {
            $0.width.height.equalTo(52)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
