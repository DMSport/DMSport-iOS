//
//  MyPageVC.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/10/29.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import UIKit
import Then
import SnapKit

class MyPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        setupView()
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
        $0.setTitleColor(UIColor(named: "HighlightColor"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 260.0)
    }
    
    private lazy var withdrawalButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.setTitle("회원 탈퇴", for: .normal)
        $0.setTitleColor(UIColor(named: "HighlightColor"), for: .normal)
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
