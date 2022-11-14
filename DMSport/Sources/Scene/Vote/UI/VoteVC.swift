import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Combine

class VoteVC: BaseVC {
    let labelData = ["축구", "농구", "배구", "배드민턴"]
    let imageData = ["Soccerball", "Basketball", "Volleyball", "Badminton"]
    
    private let backView = UIView().then {
        $0.backgroundColor = DMSportColor.baseColor.color
        $0.layer.cornerRadius = 20
    }
    private let noticeButton = UIButton().then {
        $0.backgroundColor = DMSportColor.whiteColor.color
        $0.layer.cornerRadius = 20
        $0.setTitle("플라잉 디스크 사용 안내", for: .normal)
        $0.titleLabel?.textColor = DMSportColor.blackColor.color
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.titleLabel?.textAlignment = .left
    }
    private let sportsGuideLabel = UILabel().then {
        $0.text = "종목"
        $0.textColor = DMSportIOSAsset.Color.hintColor.color
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        flowLayout.itemSize = CGSize(width: 136, height: 160)
        $0.collectionViewLayout = flowLayout
        $0.showsHorizontalScrollIndicator = false
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        $0.backgroundColor = DMSportColor.baseColor.color
    }
    private let timeGuideLabel = UILabel().then {
        $0.text = "시간"
        $0.textColor = DMSportIOSAsset.Color.hintColor.color
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    private let timeVoteTableView =  ContentWrappingTableView().then {
        $0.register(TimeVoteCell.self, forCellReuseIdentifier: "TimeVoteCell")
        $0.rowHeight = 142
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = DMSportColor.baseColor.color
    }
    private let updateTimeLabel = UILabel().then {
        $0.text = "2022/09/28 10:34 업데이트"
        $0.textAlignment = .center
        $0.textColor = DMSportColor.hintColor.color
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    func setUpCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.reloadData()
    }
    func setUpTableView() {
        timeVoteTableView.isScrollEnabled = false
        timeVoteTableView.delegate = self
        timeVoteTableView.dataSource = self
        timeVoteTableView.reloadData()
    }
    
    override func addView() {
        [
            backView,
            noticeButton
        ]
            .forEach {
                view.addSubview($0)
            }
        [
            sportsGuideLabel,
            categoryCollectionView,
            timeGuideLabel,
            timeVoteTableView,
            updateTimeLabel
        ]
            .forEach() {
                backView.addSubview($0)
            }
    }
    override func configureVC() {
        view.backgroundColor = DMSportColor.backgroundColor.color
        setUpCollectionView()
        setUpTableView()
    }
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(170)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        noticeButton.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalToSuperview().inset(108)
            //            $0.bottom.equalTo(backView.snp.top).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        sportsGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(sportsGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(4)
            $0.height.equalTo(160)
        }
        timeGuideLabel.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(28)
            $0.height.equalTo(24)
        }
        timeVoteTableView.snp.makeConstraints {
            $0.top.equalTo(timeGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
//            $0.bottom.equalTo(updateTimeLabel.snp.top).offset(40)
        }
        updateTimeLabel.snp.makeConstraints {
//            $0.height.equalTo(17)
            $0.top.equalTo(timeVoteTableView.snp.bottom)
            $0.left.right.equalToSuperview().inset(99)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(31)
        }
    }
}