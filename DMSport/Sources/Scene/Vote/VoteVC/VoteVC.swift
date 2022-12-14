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
    let postVote = BehaviorRelay<Void>(value: ())
    let typeRelay = PublishRelay<String>()
    let isBan = BehaviorRelay<Bool>(value: false)
    let banPeriod = PublishRelay<String>()
    
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
    private let logoView = UIView().then {
        $0.backgroundColor = DMSportColor.whiteColor.color
        $0.layer.cornerRadius = 20
//        $0.setTitle("플라잉 디스크 사용 안내", for: .normal)
//        $0.setTitleColor(DMSportColor.blackColor.color, for: .normal)
////        $0.setTitleColor = DMSportColor.blackColor.color
//        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
//        $0.titleLabel?.textAlignment = .left
    }
    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "DMSport_Vector")
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
    private let timeVoteTableView =  UITableView().then {
        $0.register(TimeVoteCell.self, forCellReuseIdentifier: "TimeVoteCell")
        $0.rowHeight = 142
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = DMSportColor.baseColor.color
    }
    private let updateTimeLabel = UILabel().then {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        var current_date_string = formatter.string(from: Date())
        print(current_date_string)
        
        $0.text = "\(current_date_string) 업데이트"
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
                var newCategoryLabel = ""
                switch output.categoryName.value {
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
                cell.categoryLabel.text = newCategoryLabel
                
                self.isBan.subscribe(onNext: { bool in
                    if bool {
                        cell.backView.backgroundColor = DMSportColor.disabledColor.color
                        self.timeVoteTableView.allowsSelection = false
                    } else {
                        cell.backView.backgroundColor = DMSportColor.whiteColor.color
                    }
                }).disposed(by: self.disposeBag)
                
                cell.applied.accept(items.alreadyVoted)
                cell.id  = items.voteID
                cell.leftMemebersLabel.text = "\(items.voteCount)" + "/" + "\(items.maxPeople)" + "명"
                switch items.time {
                case "LUNCH":
                    cell.lunchDinnerLabel.text = "점심시간"
                case "DINNER":
                    cell.lunchDinnerLabel.text = "저녁시간"
                default:
                    break
                }
                cell.graphWidth = (self.view.frame.width / Double(items.maxPeople)) * Double(items.voteCount)
                print(self.view.frame.width / Double(items.maxPeople))
                print(cell.graphWidth)
                
                cell.setUpView(onTapped: { id in
                    if cell.categoryLabel.text != "배드민턴" {
                        let next = PositionVoteVC()
                        next.voteID = cell.id
                        next.categoryName = cell.categoryLabel.text ?? ""
                        self.navigationController?.pushViewController(next, animated: true)
                    }
                })
                
                //                cell.votedUserButton.rx.tap
                //                    .subscribe(onNext: {
                //                        print("what")
                //                        let nextVC = VotedUserAlertVC()
                //                        nextVC.modalPresentationStyle = .overFullScreen
                //                        nextVC.modalTransitionStyle = .crossDissolve
                //                        self.present(nextVC, animated: true)
                //                        nextVC.userList.accept(items.users)
                //                    }).disposed(by: cell.disposeBag)
                
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
    }
    override func addView() {
        logoView.addSubview(logoImage)
        [
            backView,
            logoView,
            scrollView
        ]
            .forEach {
                view.addSubview($0)
            }
        scrollView.addSubview(contentView)
        [
            sportsGuideLabel,
            categoryCollectionView,
            timeGuideLabel,
            timeVoteTableView,
            updateTimeLabel
        ]
            .forEach() {
                contentView.addSubview($0)
            }
    }
    func getAccessToken() {
        self.mainProvider.rx.request(.postSignIn(PostLoginRequest(email: "basketball@dsm.hs.kr", password: "basketball123")))
            .subscribe({ response in
                switch response {
                case .success(let response):
                    debugPrint(response)
                    if let userData = try? JSONDecoder().decode(TokenModel.self, from: response.data) {
                        KeyChain.create(key: Token.accessToken, token: userData.access_token)
                        KeyChain.create(key: Token.refreshToken, token: userData.refresh_token)
                        authority = userData.authority
                        print(authority)
                        if authority.contains("ADMIN") {
                            adminBool = true
                            print(adminBool)
                        } else if authority.contains("MANAGER") {
                            managerBool = true
                            print(managerBool)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }).disposed(by: disposeBag)
    }
    override func configureVC() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.layer.cornerRadius = 20
        getAccessToken()
        view.backgroundColor = DMSportColor.backgroundColor.color
        bindViewModels()
        setUpCollectionView()
        setUpTableView()
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(170)
            $0.left.right.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            if view.frame.height > 900 {
                $0.height.equalTo(200 + 4 * 138)
            } else {
                $0.height.equalTo(700)
            }
        }
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(170)
            $0.left.right.bottom.equalToSuperview()
        }
        logoView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.top.equalToSuperview().inset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        logoImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
//            $0.left.right.equalToSuperview().inset(30)
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
            $0.height.equalTo(284)
        }
        updateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(timeVoteTableView.snp.bottom)
            $0.left.right.equalToSuperview().inset(99)
            if view.frame.height > 900 {
                $0.bottom.equalToSuperview().inset(31)
            } else {
                $0.height.equalTo(50)
            }
        }
    }
}
