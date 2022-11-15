import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Moya
import RxMoya

final class WithdrawalViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let provider = MoyaProvider<MyAPI>()
    let imageClose = UIImage(named: "CloseEye")
    let imageOpen = UIImage(named: "OpenEye")
    var toggleButton = false
    
    private lazy var withdrawalLabel = UILabel().then {
        $0.textColor = UIColor(named: "Primary")
        $0.font = .systemFont(ofSize: 58.0, weight: .bold)
        $0.text = "회원 탈퇴"
    }
    
    private lazy var logoText = UILabel().then {
        $0.textColor = UIColor(named: "Primary2")
        $0.font = .systemFont(ofSize: 35.0, weight: .bold)
        $0.text = "DMSport."
    }
    
    private lazy var forgetPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(UIColor(named: "Primary2"), for: .normal)
    }
    
    private lazy var eyeImageButton = UIButton().then {
        let image = UIImage(named: "CloseEye")
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 13)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.black.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        $0.leftViewMode = .always
        $0.textContentType = .password
        $0.isSecureTextEntry = true
    }
    
    private lazy var withdrawalButton = UIButton().then {
        let image = UIImage(named: "withdrawalButton")
        $0.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
    func setup() {
        [
            withdrawalLabel,
            logoText,
            forgetPasswordButton,
            eyeImageButton,
            passwordTextField,
            withdrawalButton
        ].forEach { view.addSubview($0) }
        
        withdrawalLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(225.0)
            $0.leading.equalToSuperview().inset(24.0)
        }
        
        logoText.snp.makeConstraints {
            $0.top.equalTo(withdrawalLabel.snp.bottom)
            $0.leading.equalTo(withdrawalLabel.snp.leading)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(logoText.snp.bottom).offset(100.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(358)
        }
        
        forgetPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(48.0)
            $0.centerX.equalToSuperview()
        }
        
        eyeImageButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).inset(30)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
            $0.width.equalTo(28)
            $0.height.equalTo(13)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(42.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(358)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.backgroundColor = .systemBackground
        setup()
        
        forgetPasswordButton.rx.tap
            .bind {
                let certificationVC = GmailCertificationViewController()
                certificationVC.modalPresentationStyle = .fullScreen
                self.present(certificationVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        withdrawalButton.rx.tap
            .bind {
                if(self.passwordTextField.text == nil || self.passwordTextField.text!.isEmpty) {
                    print("비밀번호가 없서")
                    return
                }
                self.provider.rx.request(.deleteMemberGoOut(DeletMemberGoOut(password: self.passwordTextField.text!))).subscribe { response in
                    
                    switch response {
                    case .success(let response):
                        print(response.statusCode)
                        break
                    case .failure(let error):
                        print(error)
                    }
                }.disposed(by: self.disposeBag)
            }
        
        eyeImageButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if(self.toggleButton) {
                    self.eyeImageButton.setBackgroundImage(self.imageClose, for: UIControl.State.normal)
                    self.passwordTextField.isSecureTextEntry = true
                } else {
                    self.eyeImageButton.setBackgroundImage(self.imageOpen, for: UIControl.State.normal)
                    self.passwordTextField.isSecureTextEntry = false
                }
                self.toggleButton = !self.toggleButton
            })
            .disposed(by: disposeBag)
    }
}
