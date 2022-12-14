import UIKit
import SnapKit
import RxSwift
import Then
import Moya
import RxRelay
import RxMoya

class GmailCertificationViewController: UIViewController {
    let provider = MoyaProvider<MyAPI>(plugins: [MoyaLoggingPlugin()])
    let disposeBag = DisposeBag()
    var password = ""
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.black.cgColor
        
        emailTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        emailTextField.leftViewMode = .always
        
        checkEmailTextField.layer.cornerRadius = 20
        checkEmailTextField.layer.borderWidth = 0.5
        checkEmailTextField.layer.borderColor = UIColor.black.cgColor
        
        checkEmailTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        checkEmailTextField.leftViewMode = .always
        certificationButton.layer.cornerRadius = 20
        setupLayout()
        
        let view = SignupView()
        
        okButton.rx.tap
            .bind {
                if(self.emailTextField.text! == "" || self.emailTextField.text!.isEmpty) {
                    print("이메일이 없서")
                    return
                }
                if(self.checkEmailTextField.text! == "" || self.checkEmailTextField.text!.isEmpty) {
                    print("인증번호가 없서")
                    return
                }
                self.provider.rx.request(.postMailAuthentication(PostmailAuthenticationRequest(email: self.emailTextField.text!, auth_code: self.checkEmailTextField.text!)))
                    .subscribe { response in
                    switch response {
                    case .success(let response):
                        print(response.statusCode)
                        break
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }.disposed(by: view.disposeBag)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if(self.id.isEmpty) {
                        print("이름 없서")
                        return
                    }
                    if(self.password.isEmpty) {
                        print("비밀번호 없서")
                        return
                    }
                    if(self.emailTextField.text == nil || self.emailTextField.text!.isEmpty) {
                        print("이메일이 없어")
                    }
                    self.provider.rx.request(.postSignUp(PostSignRequest(email: self.emailTextField.text!, password: self.password, name: self.id))).subscribe { response in
                        switch response {
                        case .success(let response):
                            print(response.statusCode)
                            EmailSaver.saver.updateEmail(self.emailTextField.text)
                            PasswordSaver.saver.updatePassword(self.password)
                            let loginVC = LoginViewController()
                            self.navigationController?.pushViewController(loginVC, animated: true)
                            break
                        case .failure(let error):
                            print("error: \(error)")
                        }
                    }.disposed(by: view.disposeBag)
                }
            }.disposed(by: disposeBag)
        
        certificationButton.rx.tap
            .bind {
                if(self.emailTextField.text == nil || self.emailTextField.text!.isEmpty) {
                    print("이메일이 없어")
                }
                self.provider.rx.request(.postSignupSend(PostSignupSendRequest(email: self.emailTextField.text!))).subscribe { response in
                    switch response {
                    case .success(let response):
                        print(response.statusCode)
                        break
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }.disposed(by: self.disposeBag)
            }.disposed(by: disposeBag)
    }
    
    private lazy var fristText = UILabel().then {
        $0.textColor = DMSportIOSAsset.Color.mainColor.color
        $0.font = .systemFont(ofSize: 58.0, weight: .bold)
        $0.text = "인증하기"
    }
    
    private lazy var logoText = UILabel().then {
        $0.textColor = DMSportIOSAsset.Color.subtitleColor.color
        $0.font = .systemFont(ofSize: 35.0, weight: .bold)
        $0.text = "DMSport."
    }
    
    private lazy var emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private lazy var checkEmailTextField = UITextField().then {
        $0.placeholder = "인증번호"
        $0.borderStyle = UITextField.BorderStyle.none
        $0.keyboardType = UIKeyboardType.emailAddress
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private lazy var certificationButton = UIButton().then {
        $0.setTitle("인증", for: .normal)
        $0.backgroundColor = DMSportIOSAsset.Color.mainColor.color
    }
    
    private lazy var okButton = UIButton().then {
        let image = UIImage(named: "okButton")
        $0.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        $0.setBackgroundImage(image, for: UIControl.State.normal)
    }
    
}

extension GmailCertificationViewController {
    
    func setupLayout() {
        [
            fristText,
            logoText,
            emailTextField,
            checkEmailTextField,
            certificationButton,
            okButton
            
        ].forEach { view.addSubview($0) }
        
        fristText.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(160)
            $0.leading.equalToSuperview().offset(25)
        }
        
        logoText.snp.makeConstraints {
            $0.top.equalTo(fristText.snp.bottom)
            $0.leading.equalTo(fristText.snp.leading)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(logoText.snp.bottom).offset(42)
            $0.leading.equalTo(checkEmailTextField.snp.leading)
            $0.trailing.equalToSuperview().inset(112)
            $0.height.equalTo(50)
        }

        checkEmailTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(32)
            $0.centerX.equalTo(view)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
        }
        
        certificationButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.top)
            $0.leading.equalTo(emailTextField.snp.trailing).offset(10)
            $0.height.equalTo(48)
            $0.width.equalTo(80)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(55)
            $0.height.equalTo(50)
            $0.width.equalTo(355)
            $0.centerX.equalTo(view)
        }
    }
}
