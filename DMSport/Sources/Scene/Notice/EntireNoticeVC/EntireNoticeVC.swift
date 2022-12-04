import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class EntireNoticeVC: BaseVC {
//    var noticeList: [DummyItems] = []
//    let dummyList = Dummies()
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
//    func setUpEntireTableView() {
//        entireNoticeTableView.delegate = self
//        entireNoticeTableView.dataSource = self
//        entireNoticeTableView.reloadData()
//    }
//    func addDummyData() {
//        noticeList = [
//            dummyList.entireItem1, dummyList.entireItem2, dummyList.entireItem1, dummyList.entireItem2, dummyList.entireItem1, dummyList.entireItem2, dummyList.entireItem1, dummyList.entireItem2, dummyList.entireItem1, dummyList.entireItem2
//        ]
//    }
    override func addView() {
        view.addSubview(scrollView)
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
//        setUpEntireTableVaiew()
//        addDummyData()
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
//            if noticeList.count * 133 > 800 {
//                $0.height.equalTo(200 + (noticeList.count) * 133)
//            } else {
//                $0.height.equalTo(900)
//            }
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
    }
}
