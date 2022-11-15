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
