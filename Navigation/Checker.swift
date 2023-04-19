import UIKit

public class Checker {
    public static let shared = Checker()
    
    private let login = "aphilat"
    private let password = "123"
    
    func check (logg: String, passw:String) -> Bool {
        logg == self.login && passw == self.password
    }
}

protocol LoginViewControllerDelegate {
    func check (checker:Checker, user: String, password: String) -> Bool
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(checker: Checker, user: String, password:String) -> Bool {
        return checker.check(logg: user, passw: password)
    }
}

protocol LoginFactory {
    func makeLoginInspector () -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
    
    
}
