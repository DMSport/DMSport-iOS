//
//  EmailSaver.swift
//  DMSport-iOS
//
//  Created by 박준하 on 2022/11/11.
//  Copyright © 2022 com.DMS. All rights reserved.
//

import Foundation

public class EmailSaver {
    public static var saver: EmailSaver = EmailSaver()
    
    private var email: String?
    
    init() {
        email = nil
    }
    
    public func updateEmail(_ email: String?) {
        self.email = email
    }
    
    public func getSavedEmail() -> String? {
        return email
    }
}
