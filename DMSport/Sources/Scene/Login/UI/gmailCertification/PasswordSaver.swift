//
//  PasswordSaver.swift
//  
//
//  Created by 박준하 on 2022/11/13.
//

import Foundation

public class PasswordSaver {
    public static var saver: PasswordSaver = PasswordSaver()
    
    private var password: String?
    
    init() {
        password = nil
    }
    
    public func updatePassword(_ password: String?) {
        self.password = password
    }
    
    public func getSavedpassword() -> String? {
        return password
    }
}

