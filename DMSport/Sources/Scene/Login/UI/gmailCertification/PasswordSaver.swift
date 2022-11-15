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

