import UIKit
import RxSwift
import RxCocoa
import RxRelay
import Then
import SnapKit
import RxMoya

class MyPageViewController: UIViewController {
    private let getInfo = BehaviorRelay<Void>(value: ())
    private let viewModel = MyPageVM()
    let disposBag = DisposeBag()
    
    private func getMyInfo() {
        let input = MyPageVM.Input(buttonDidTap: getInfo.asDriver())
        let output = viewModel.transform(input)
        
//        nameLabel.text = output.name.value
//        userLabel.text = output.authString.value
//        emailLabel.text = output.email.value
        
        output.name
            .bind {_ in
                self.nameLabel.text = output.name.value
            }.disposed(by: disposBag)
        output.email
            .bind {_ in
                self.emailLabel.text = output.email.value
            }.disposed(by: disposBag)
        output.authString
            .bind {_ in
                self.userLabel.text = output.authString.value
            }.disposed(by: disposBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyInfo()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setupView()
        
        passwordChageButton.rx.tap
            .bind {
                let chagePasswordVC = ChangePasswordViewController()
                self.navigationController?.pushViewController(chagePasswordVC, animated: true)
            }
            .disposed(by: disposBag)
        
        logoutButton.rx.tap
            .bind {
                Token.accessToken = ""
                Token.refreshToken = ""
                Token().accessString = nil
                Token().refreshString = nil
                authority = ""

                let loginVC = LoginViewController()
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            .disposed(by: disposBag)
        
        withdrawalButton.rx.tap
            .bind {
                let withdrawalVC = WithdrawalViewController()
                self.navigationController?.pushViewController(withdrawalVC, animated: true)
            }
            .disposed(by: disposBag)
        
    }
    
    private lazy var modalView = UIView().then {
        $0.backgroundColor = UIColor(named: "BaseColor")
        $0.layer.cornerRadius = 20
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.text = "김학생"
        $0.font = .systemFont(ofSize: 20.0, weight: .semibold)
        
    }
    
    private lazy var userLabel = UILabel().then {
        $0.text = "USER"
        $0.font = .systemFont(ofSize: 14.0, weight: .regular)
        $0.textColor = UIColor(named: "HintColor")
    }
    
    private lazy var emailLabel = UILabel().then {
        $0.text = "krpjs0508@dsm.hs.kr"
        $0.font = .systemFont(ofSize: 14.0, weight: .regular)
        $0.textColor = UIColor(named: "HintColor")
    }
    
    private lazy var passwordChageButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(UIColor(named: "HintColor"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 230.0)
    }
    
    private lazy var autoJoinButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.setTitle("종목 빈자리 자동 참여", for: .normal)
        $0.setTitleColor(UIColor(named: "HintColor"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 180.0)
    }
    
    private lazy var logoutButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(DMSportIOSAsset.Color.highlightColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 260.0)
    }
    
    private lazy var withdrawalButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.setTitle("회원 탈퇴", for: .normal)
        $0.setTitleColor(DMSportIOSAsset.Color.highlightColor.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 260.0)
    }
}


extension MyPageViewController {
    func setupView() {
        [
            modalView,
            nameLabel,
            userLabel,
            emailLabel,
            passwordChageButton,
            autoJoinButton,
            logoutButton,
            withdrawalButton
        ].forEach { view.addSubview($0)}
        
        let buttonHeight = 48.0
        let buttonWidth = 358.0
        
        modalView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170.0)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(modalView.snp.top).offset(24.0)
            $0.leading.equalToSuperview().offset(28.0)
        }
        
        userLabel.snp.makeConstraints {
            $0.top.equalTo(modalView.snp.top).offset(31.0)
            $0.leading.equalTo(modalView.snp.leading).inset(88.0)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        passwordChageButton.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(buttonHeight)
            $0.width.equalTo(buttonWidth)
        }
        
        autoJoinButton.snp.makeConstraints {
            $0.top.equalTo(passwordChageButton.snp.bottom).offset(12.0)
            $0.leading.equalTo(passwordChageButton.snp.leading)
            $0.height.equalTo(buttonHeight)
            $0.width.equalTo(buttonWidth)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(autoJoinButton.snp.bottom).offset(12.0)
            $0.leading.equalTo(passwordChageButton.snp.leading)
            $0.height.equalTo(buttonHeight)
            $0.width.equalTo(buttonWidth)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(12.0)
            $0.leading.equalTo(passwordChageButton.snp.leading)
            $0.height.equalTo(buttonHeight)
            $0.width.equalTo(buttonWidth)
        }
    }
}
