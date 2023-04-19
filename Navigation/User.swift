import UIKit

public class User {
    
    public var userLogin: String
    public var userFullName:String
    public var userStatus: String
    public var userAvatar: UIImage
    
    init(userLogin: String, userFullName: String, userStatus: String, userAvatar: UIImage) {
        self.userLogin = userLogin
        self.userFullName = userFullName
        self.userStatus = userStatus
        self.userAvatar = userAvatar
    }
}

protocol UserService {
    var user: User {get}
    func userChecking (userLogin: String) -> User?
}

extension UserService {
    func userChecking (userLogin: String)-> User? {
        return userLogin == user.userLogin ? user : nil
    }
}

public class CurrentUserService: UserService {
    public var user = User(userLogin: "aphilatt", userFullName: "Current User", userStatus: "Learning swift...", userAvatar: UIImage(named: "avatar")!)
        
}

public class TestUserService: UserService {
    public var user = User(userLogin: "aphilat", userFullName: "Test User", userStatus: "Test test test", userAvatar: UIImage(named: "4")!)
}
