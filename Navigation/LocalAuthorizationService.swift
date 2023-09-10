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
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Разрешите использовать Face ID") { success, error in
                DispatchQueue.main.async {
                    if success {
                        authorizationFinished(true)
                    } else {
                        authorizationFinished(false)
                    }
                }
            }
        } else {
            authorizationFinished(false)
        }
        
    }
}
