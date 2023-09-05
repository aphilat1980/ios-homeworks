import UIKit
import FirebaseAuth

public class Checker {
    public static let shared = Checker()
    
    private let login = "aphilat"
    private let password = "123"
    
    func check (logg: String, passw:String) -> Bool {
        logg == self.login && passw == self.password
    }
}

protocol LoginViewControllerDelegate: CheckerServiceProtocol, AnyObject {
    func check (checker:Checker, user: String, password: String) -> Bool

}

class LoginInspector: LoginViewControllerDelegate {
    
    func checkCredentials(email: String, password: String, completion: @escaping (_ authResult: AuthResult)-> Void) {

        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            
            if let error {
                switch error.localizedDescription {
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    completion (.noUser)
                default:
                    completion (.failure(error.localizedDescription))
                    return
               }
            }
            completion (.success)
        }
        
    }
    
    func signUp(email: String, password: String, completion: @escaping (_ signUpResult: SighUpResult)-> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error {
               completion (.failure(error.localizedDescription))
               return
            }
            completion (.success)
        }
        
    }
    
    func check(checker: Checker, user: String, password:String) -> Bool {
        return checker.check(logg: user, passw: password)
    }
}

protocol LoginFactory {
    func makeLoginInspector () -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        print ("LInspector is done")
        return LoginInspector()
    }
    
    
}

protocol CheckerServiceProtocol {
    func checkCredentials (email: String, password: String, completion: @escaping (_ authResult: AuthResult) -> Void)
    func signUp (email: String, password: String, completion: @escaping (_ signUpResault:SighUpResult)-> Void)
    
}
 
enum AuthResult: Equatable {
    case success
    case noUser
    case failure (String)
}

enum SighUpResult: Equatable {
    case success
    case failure (String)
}
