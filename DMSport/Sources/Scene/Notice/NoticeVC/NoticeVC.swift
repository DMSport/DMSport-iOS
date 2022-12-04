import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya
import RxMoya
import RxRelay

class NoticeVC: BaseVC {
    private let mainProvider = MoyaProvider<MyAPI>()
    private let getNotices = BehaviorRelay<Void>(value: ())
    let viewModel = RecentNoticeVM()
    var count: Int = 0
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let backView = UIView().then {
        $0.backgroundColor = DMSportColor.baseColor.color
        $0.layer.cornerRadius = 20
    }
    private let entireGuideLabel = UILabel().then {
        $0.text = "전체 공지사항"
        $0.textColor = DMSportIOSAsset.Color.hintColor.color
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    private let entireNextButton = UIButton().then {
        $0.setTitle("전체 공지사항 더 보기  >", for: .normal)
        $0.setTitleColor(DMSportColor.hintColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    let entireNoticeTableView = UITableView().then {
        $0.register(NoticeCell.self, forCellReuseIdentifier: "EntireNotice")
        $0.rowHeight =  145
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    private let categoryGuideLabel = UILabel().then {
        $0.text = "종목별 공지사항"
        $0.textColor = DMSportIOSAsset.Color.hintColor.color
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    private let categoryNextButton = UIButton().then {
        $0.setTitle("종목별 공지사항 더 보기  >", for: .normal)
        $0.setTitleColor(DMSportColor.hintColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    let categoryTableView =  UITableView().then {
        $0.register(NoticeCell.self, forCellReuseIdentifier: "CategoryNotice")
        $0.rowHeight = 145
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    func setUpEntireTableView() {
        entireNoticeTableView.isScrollEnabled = false
        entireNoticeTableView.delegate = self
    }
    func setUpCategoryTableView() {
        categoryTableView.isScrollEnabled = false
        categoryTableView.delegate = self
    }
    private func bindViewModels() {
        let input = RecentNoticeVM.Input(getData: getNotices.asDriver())
        let output = viewModel.transform(input)
        
        output.entireRecentNotices.bind(to: entireNoticeTableView.rx.items(
            cellIdentifier: "EntireNotice",
            cellType: NoticeCell.self)) { row, items, cell in
                print(items)
                cell.noticeTitle.text =  items.title
                cell.noticeContent.text = items.contentPreview
                cell.noticeDetails.text = items.createdAt
            }.disposed(by: disposeBag)
        output.categoryRecentNotices.bind(to: categoryTableView.rx.items(
            cellIdentifier: "CategoryNotice",
            cellType: NoticeCell.self)) { row, items, cell in
                print(items)
                cell.noticeTitle.text = items.title
                cell.noticeContent.text = items.contentPreview
                cell.noticeDetails.text = items.createdAt + " / " + items.type
            }.disposed(by: disposeBag)
    }
    override func addView() {
        [
            backView,
            scrollView
        ] .forEach {
            view.addSubview($0)
        }
        scrollView.addSubview(contentView)
        [
            entireGuideLabel,
            entireNextButton,
            entireNoticeTableView,
            categoryGuideLabel,
            categoryNextButton,
            categoryTableView
        ] .forEach {
            contentView.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.backgroundColor.color
        scrollView.contentInsetAdjustmentBehavior = .never
        bindViewModels()
        setUpEntireTableView()
        setUpCategoryTableView()
        entireNextButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(EntireNoticeVC(), animated: true)
            }).disposed(by: disposeBag)
        categoryNextButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(CategoryNoticeVC(), animated: true)
            }).disposed(by: disposeBag)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.left.right.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(500 + 4 * 138)
        }
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(89)
            $0.left.right.bottom.equalToSuperview()
        }
        entireGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(28)
        }
        entireNextButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().inset(25)
        }
        entireNoticeTableView.snp.makeConstraints {
            $0.top.equalTo(entireGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(290)
        }
        categoryGuideLabel.snp.makeConstraints {
            $0.top.equalTo(entireNoticeTableView.snp.bottom).offset(33)
            $0.leading.equalToSuperview().inset(28)
        }
        categoryNextButton.snp.makeConstraints {
            $0.top.equalTo(entireNoticeTableView.snp.bottom).offset(38)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().inset(25)
        }
        categoryTableView.snp.makeConstraints {
            $0.top.equalTo(categoryGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(290)
        }
    }
}
