import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya
import RxMoya
import RxRelay

class NoticeDetailVC: BaseVC {
    private let mainProvider = MoyaProvider<MyAPI>()
    private let getNotices = BehaviorRelay<Void>(value: ())
    let viewModel = NoticeDetailVM()
    var id = Int()
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let backView = UIView().then {
        $0.backgroundColor = DMSportColor.whiteColor.color
        $0.layer.cornerRadius = 20
    }
    let noticeTitle =  UILabel().then {
        $0.textColor = DMSportColor.blackColor.color
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    let noticeDetail = UILabel().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    let noticeContent = UITextView().then {
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .justified
    }
    private func bindViewModels() {
        let input = NoticeDetailVM.Input(noticeID: id, getDetail: getNotices.asDriver())
        let output = viewModel.transfrom(input)
        
        output.seeNotice.subscribe(onNext: { [unowned self] info in
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate]
            let createdTime = formatter.date(from: info?.createdAt ?? "")
            let createdWhen: String = "\(createdTime!)"
            let endIndex = createdWhen.index(createdWhen.startIndex, offsetBy: 10)
            let range = ...endIndex
            
            var newCategoryLabel = ""
            switch info?.type {
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

            noticeTitle.text = info?.title
            noticeDetail.text = createdWhen[range] + " /  " + newCategoryLabel
            noticeContent.text = info?.content
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            backView,
            scrollView
        ] .forEach {
            view.addSubview($0)
        }
        [
            noticeTitle,
            noticeDetail,
            noticeContent
        ] .forEach {
            backView.addSubview($0)
        }
        scrollView.addSubview(contentView)
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.baseColor.color
        scrollView.contentInsetAdjustmentBehavior = .never
        bindViewModels()
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
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
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        noticeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(100)
        }
        noticeDetail.snp.makeConstraints {
            $0.top.equalTo(noticeTitle.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(12)
        }
        noticeContent.snp.makeConstraints {
            $0.top.equalTo(noticeDetail.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}
