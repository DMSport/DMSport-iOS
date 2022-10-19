//
//  MainSignupVC.swift
//  
//
//  Created by 박준하 on 2022/10/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let view = SignupView()
        view.mainButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                view.SignupButtonTap(self!)
                print("💣🐙🪄")
            })
            .disposed(by: view.disposeBag)
        view.updateWith(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
