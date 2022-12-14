import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya
import RxMoya

class CategoryNoticeVC: BaseVC {
    private let mainProvider = MoyaProvider<MyAPI>()
    private let getNotices = BehaviorRelay<Void>(value: ())
    let viewModel = CategoryNoticeVM()
    var categoryNoticeCount: Int = 1
    var noticeID = Int()
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let categoryGuideLabel = UILabel().then {
        $0.text = "종목별 공지사항"
        $0.textColor = DMSportColor.hintColor.color
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    let categoryNoticeTableView = ContentWrappingTableView().then {
        $0.register(NoticeCell.self, forCellReuseIdentifier: "CategoryNotice")
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
        let input = CategoryNoticeVM.Input(getNotices: getNotices.asDriver(), loadDetail: categoryNoticeTableView.rx.itemSelected.asSignal())
        let output = viewModel.transfrom(input)
        
        output.allNotices.bind(to: categoryNoticeTableView.rx.items(
            cellIdentifier: "CategoryNotice",
            cellType: NoticeCell.self)) { row, items, cell in
                if items.type != "ALL" {
                    let formatter = ISO8601DateFormatter()
                    formatter.formatOptions = [.withFullDate]
                    let createdTime = formatter.date(from: items.createdAt)
                    let createdWhen: String = "\(createdTime!)"
                    let endIndex = createdWhen.index(createdWhen.startIndex, offsetBy: 10)
                    let range = ...endIndex
                    
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
                    
                    cell.noticeTitle.text = items.title
                    cell.noticeDetails.text = createdWhen[range] + " /  " + newCategoryLabel
                    cell.noticeContent.text = items.contentPreview
                    self.categoryNoticeCount += 1
                    print(self.categoryNoticeCount)
                    self.updateConstraints()
                    
                    cell.selectionStyle = .none
                } else {
                    print(items.type)
                    cell.selectionStyle = .none
                }
                
                if adminBool || managerBool {
                    cell.ellipsisButton.rx.tap
                        .subscribe(onNext: {
                            let editAlert = NoticeEditAlertVC()
                            editAlert.modalPresentationStyle = .overFullScreen
                            editAlert.modalTransitionStyle = .crossDissolve
                            self.present(editAlert, animated: true)
                            editAlert.noticeTitleTextField.text = items.title
                            editAlert.noticeContentTextView.text = items.contentPreview
                            editAlert.noticeIDLabel.text = "\(items.id)"
                        }).disposed(by: cell.disposeBag)
                }
                
            }.disposed(by: disposeBag)
        
        output.detailIndex.asObservable()
            .subscribe(onNext: { id in
                self.noticeID = id
            }).disposed(by: disposeBag)
        
        categoryNoticeTableView.rx.itemSelected
            .subscribe(onNext: { _ in
                let next = NoticeDetailVC()
                next.id = self.noticeID
                self.navigationController?.pushViewController(next, animated: true)
            }).disposed(by: disposeBag)
    }
    private func updateConstraints() {
        contentView.snp.remakeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            if categoryNoticeCount * 133 > 800 {
                $0.height.equalTo(100 + categoryNoticeCount * 133)
            } else {
                $0.height.equalTo(900)
            }
        }
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
            categoryGuideLabel,
            categoryNoticeTableView
            
        ] .forEach {
            contentView.addSubview($0)
        }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
        scrollView.contentInsetAdjustmentBehavior = .never
        bindViewModels()
        if adminBool || managerBool {
            newNoticeButton.rx.tap
                .subscribe(onNext: {
                    let newNotice = NewNoticeAlertVC()
                    newNotice.modalPresentationStyle = .overFullScreen
                    newNotice.modalTransitionStyle = .crossDissolve
                    self.present(newNotice, animated: true)
                }).disposed(by: disposeBag)
        } else {
            newNoticeButton.tintColor = .clear
            newNoticeButton.backgroundColor = .clear
            newNoticeButton.setImage(nil, for: .normal)
        }
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            if categoryNoticeCount * 133 > 800 {
                $0.height.equalTo(200 + categoryNoticeCount * 133)
            } else {
                $0.height.equalTo(900)
            }
        }
        categoryGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        categoryNoticeTableView.snp.makeConstraints {
            $0.top.equalTo(categoryGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        newNoticeButton.snp.makeConstraints {
            $0.width.height.equalTo(52)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
