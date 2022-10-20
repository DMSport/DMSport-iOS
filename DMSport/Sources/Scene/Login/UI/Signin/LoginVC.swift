//
//  MainLoginVC.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/17.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import RxRelay

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let view = LoginView()
        view.forgetPassword.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                view.nextButtonTap()
            })
            .disposed(by: view.disposeBag)
        
        view.mainButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                view.signupButtonTap(view.mainButton, self)
                print("회원가입으로😘")
            })
            .disposed(by: view.disposeBag)
        view.updateWith(self)
        
        view.firstTextField
            .rx.text
            .orEmpty
            .bind(to: view.loginVM.email)
            .disposed(by: view.disposeBag)
        
        view.secondTextField
            .rx.text
            .orEmpty
            .bind(to: view.loginVM.password)
            .disposed(by: view.disposeBag)
        
        
        view.loginButton
            .rx.tap
            .do(onNext :{[unowned self] in
                self.view.endEditing(true)
            })
            .subscribe(onNext: {
                if view.loginVM.validation() {
                    view.loginVM.callLoginAPI()
                    print("🔥🚀")
                } else {
                    //error massage
                    view.LoginButtonTap(self)
                }
            })
                .disposed(by: view.disposeBag)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
