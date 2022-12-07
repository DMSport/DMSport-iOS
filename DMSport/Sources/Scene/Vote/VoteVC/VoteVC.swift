import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import Moya
import RxMoya

class VoteVC: BaseVC {
    let type = ["BADMINTON", "SOCCER", "BASKETBALL", "VOLLEYBALL"]
    let labelData = ["배드민턴", "축구", "농구", "배구"]
    let imageData = ["Badminton", "SoccerBall", "BasketBall", "VolleyBall"]
    
    private let mainProvider = MoyaProvider<MyAPI>()
    private let getVotes = BehaviorRelay<Void>(value: ())
    let viewModel = TodayVoteVM()
    let typeRelay = PublishRelay<String>()
    let isBan = PublishRelay<Bool>()
    let banPeriod = PublishRelay<String>()
    
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
    }
    private func bindViewModels() {
        let input = TodayVoteVM.Input(
            getVotes: getVotes.asDriver(),
            type: typeRelay.asDriver(onErrorJustReturn: ""),
            loadDetail: categoryCollectionView.rx.itemSelected.asSignal()
        )
        let output = viewModel.transfrom(input)
        
        
        output.voteObject.asObservable()
            .subscribe(onNext: {
                self.isBan.accept($0.ban)
            }).disposed(by: disposeBag)
        
        output.todayVotes.bind(to: timeVoteTableView.rx.items(
            cellIdentifier: "TimeVoteCell",
            cellType: TimeVoteCell.self)) { row, items, cell in
                output.categoryName.asObservable()
                    .map {
                        switch $0 {
                        case "BADMINTON":
                            return "배드민턴"
                        case "SOCCER":
                            tapCell()
                            return "축구"
                        case "BASKETBALL":
                            tapCell()
                            return "농구"
                        case "VOLLEYBALL":
                            tapCell()
                            return "배구"
                        default:
                            return ""
                        }
                    }.subscribe(onNext: {
                        cell.categoryLabel.text = $0
                    }).disposed(by: self.disposeBag)
                
                self.isBan.asObservable()
                    .subscribe(onNext: { bool in
                    if bool {
                        cell.backView.backgroundColor = DMSportColor.disabledColor.color
                        self.timeVoteTableView.allowsSelection = false
                    } else {
                        cell.backView.backgroundColor = DMSportColor.whiteColor.color
                    }
                }).disposed(by: self.disposeBag)
                
                cell.applied.accept(items.alreadyVoted)
                cell.id.accept(items.voteID)
                cell.leftMemebersLabel.text = "\(items.voteCount)" + "/" + "\(items.maxPeople)" + "명"
                switch items.time {
                case "LUNCH":
                    cell.lunchDinnerLabel.text = "점심시간"
                case "DINNER":
                    cell.lunchDinnerLabel.text = "저녁시간"
                default:
                    break
                }
                cell.graphWidth = cell.graphView.frame.width * CGFloat((items.voteCount / items.maxPeople))
                
                func tapCell() {
                    cell.applyButton.rx.tap
                        .subscribe(onNext: {
                            self.navigationController?.pushViewController(PositionVoteVC(), animated: true)
                        }).disposed(by: cell.disposeBag)
                }
                
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
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
    func getAccessToken() {
        self.mainProvider.rx.request(.postSignIn(PostLoginRequest(email: "admin@dsm.hs.kr", password: "admin123")))
            .subscribe({ response in
                switch response {
                case .success(let response):
                    debugPrint(response)
                    if let userData = try? JSONDecoder().decode(TokenModel.self, from: response.data) {
                        KeyChain.create(key: Token.accessToken, token: userData.access_token)
                        KeyChain.create(key: Token.refreshToken, token: userData.refresh_token)
                    }
                case .failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    override func configureVC() {
        getAccessToken()
        view.backgroundColor = DMSportColor.backgroundColor.color
        bindViewModels()
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
        }
        updateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(timeVoteTableView.snp.bottom)
            $0.left.right.equalToSuperview().inset(99)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(31)
        }
    }
}
