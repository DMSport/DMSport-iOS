//
//  MomViewConfigure.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/18.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation
import UIKit

extension BaseSignView {
    @objc func loginButtonTap(_ sender: UIButton!){
        print("🫶 로그인 드가자")
    }
    
    @objc func signupButtonTap(_ sender: UIButton!,_ controller: UIViewController){
        print("☺️ 회원가입 드가자")
        let signupVC = SignUpViewController()
        signupVC.modalPresentationStyle = .fullScreen
        controller.present(signupVC, animated: true)
    }
}
