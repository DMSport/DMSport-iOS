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
    let viewModel = NoticeVM()
    
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
    func setUpTableView() {
        entireNoticeTableView.isScrollEnabled = false
        categoryTableView.isScrollEnabled = false
    }
    private func bindViewModels() {
        let input = NoticeVM.Input(getData: getNotices.asDriver())
        let output = viewModel.transform(input)
        
        output.entireRecentNotices.bind(to: entireNoticeTableView.rx.items(
            cellIdentifier: "EntireNotice",
            cellType: NoticeCell.self)) { row, items, cell in
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withFullDate]

                let createdTime = formatter.date(from: items.createdAt)
                let createdWhen: String = "\(createdTime!)"
                let endIndex = createdWhen.index(createdWhen.startIndex, offsetBy: 10)
                let range = ...endIndex
                
                cell.noticeTitle.text =  items.title
                cell.noticeContent.text = items.contentPreview
                cell.noticeDetails.text = "\(createdWhen[range])"
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
        output.categoryRecentNotices.bind(to: categoryTableView.rx.items(
            cellIdentifier: "CategoryNotice",
            cellType: NoticeCell.self)) { row, items, cell in
                cell.noticeTitle.text = items.title
                cell.noticeContent.text = items.contentPreview
                var newCategoryLabel = ""
                switch items.type {
                case "BADMINTON":
                    newCategoryLabel = "배드민턴"
                case "SOCCER":
                    newCategoryLabel = "축구"
                case "BASKETBALL":
                    newCategoryLabel = "농구"
                case "VOLLEYBALL":
                    newCategoryLabel = "배구"
                default:
                    newCategoryLabel = ""
                }
                
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withFullDate]

                let createdTime = formatter.date(from: items.createdAt)
                let createdWhen: String = "\(createdTime!)"
                let endIndex = createdWhen.index(createdWhen.startIndex, offsetBy: 10)
                let range = ...endIndex
                
                cell.noticeDetails.text = createdWhen[range] + " /  " + newCategoryLabel
                cell.selectionStyle = .none
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
        setUpTableView()
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
            if view.frame.height > 900 {
                $0.height.equalTo(300 + 4 * 138)
            } else {
                $0.height.equalTo(800)
            }
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
