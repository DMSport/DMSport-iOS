import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then

class VoteVC: BaseVC<VoteVCReactor> {
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
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let switchGuideLabel = UILabel().then {
        $0.text = "빈자리 자동 참여"
        $0.textColor = DMSportIOSAsset.Color.hintColor.color
        $0.font = .systemFont(ofSize: 14, weight: .bold)
    }
    private let autoSwitch = UISwitch().then {
        $0.isOn = false
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.75)
        $0.onTintColor = DMSportColor.mainColor.color
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
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let timeVoteTableView =  UITableView().then {
        $0.register(TimeVoteCell.self, forCellReuseIdentifier: "TimeVoteCell")
        $0.rowHeight = 138
        $0.showsVerticalScrollIndicator = false
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
            switchGuideLabel,
            autoSwitch,
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
        }
        switchGuideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.height.equalTo(17)
            $0.right.equalToSuperview().inset(72)
        }
        autoSwitch.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.right.equalToSuperview().inset(16)
            $0.width.equalTo(48)
//            $0.height.equalTo(24)
//            $0.bottom.equalTo(categoryCollectionView.snp.top).offset(12)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.left.right.equalToSuperview().inset(4)
            $0.height.equalTo(160)
        }
        timeGuideLabel.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(28)
        }
        timeVoteTableView.snp.makeConstraints {
//            $0.top.equalTo(timeGuideLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(updateTimeLabel.snp.top).offset(40)
        }
        updateTimeLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(99)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(31)
        }
    }
}

extension VoteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let voteCell = tableView.dequeueReusableCell(withIdentifier: "TimeVoteCell", for: indexPath) as! TimeVoteCell
        voteCell.categoryLabel.text = "축구"
        voteCell.leftMemebersLabel.text = "2/4명"
        voteCell.lunchDinnerLabel.text = "점심시간"

        return voteCell
    }
}
