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
    func userChecking (userLogin: String) -> User?
}

public class CurrentUserService: UserService {
    
    public var currentUser: User?
    func userChecking(userLogin: String) -> User? {
        //создаю массив с действующими юзерами
        let userArray = [
            User(userLogin: "wolf", userFullName: "WWolf", userStatus: "Wolf eat Red Hat Girl", userAvatar: UIImage(named: "6")!),
            User(userLogin: "aphilat", userFullName: "Hipster Cat", userStatus: "Learning Swift", userAvatar: UIImage (named: "avatar")!),
            User(userLogin: "cat", userFullName: "Big Fat Cat", userStatus: "Drinking Milk", userAvatar: UIImage (named: "4")!)
        ]
        //выполняю проверку на наличия юзера в созданном массиве
        for i in userArray {
            if userLogin == i.userLogin {
                currentUser = i
                break
            } else {
                currentUser = nil
            }
        }
        return currentUser
    }
}

public class TestUserService: UserService {
    func userChecking(userLogin: String) -> User? {
        return User(userLogin: userLogin, userFullName: "Test User", userStatus: "Test test test", userAvatar: UIImage (named: "1")!)
    }
}
