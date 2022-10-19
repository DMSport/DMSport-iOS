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
import Then
import RxRelay

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let view = LoginView()
        view.forgetPassword.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                view.nextButtonTap()
            })
            .disposed(by: view.disposeBag)
        
        view.mainButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                print("회원가입으로😘")
            })
            .disposed(by: view.disposeBag)
        view.updateWith(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
