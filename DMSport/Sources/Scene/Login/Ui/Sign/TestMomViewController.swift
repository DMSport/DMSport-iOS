//
//  StartInheritanceViewController.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/17.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import Then

class TestMomViewController: UIViewController {
    
    let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let mom = MomView()
        view.addSubview(mom)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
}

extension TestMomViewController {
    @objc func loginButtonTap(_ sender: UIButton!){
        print("🫶 로그인 드가자")
    }
    
    @objc func signupButtonTap(_ sender: UIButton!){
        print("☺️ 회원가입 드가자")
        let signupVC = MainSignUpViewController()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true)
    }
}
