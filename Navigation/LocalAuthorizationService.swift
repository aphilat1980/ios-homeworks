//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Александр Филатов on 09.09.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        
        let context = LAContext()
        var error: NSError?
        let canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if error != nil {
            print (error?.localizedDescription)
            authorizationFinished(false)
        }
        guard canEvaluatePolicy else {
            print (canEvaluatePolicy)
            print ("here we are")
            authorizationFinished(false)
            return
        }
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Разрешите использовать Face ID") { success, error in
            DispatchQueue.main.async {
                if success {
                    authorizationFinished(true)
                } else {
                    print (error?.localizedDescription)
                    authorizationFinished(false)
                }
            }
        }
    
}
    
    
    
}
