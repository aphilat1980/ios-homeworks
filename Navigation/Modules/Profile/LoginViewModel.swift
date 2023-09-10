//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Александр Филатов on 04.09.2023.
//

import Foundation
import UIKit

class LoginViewModel: ViewModelProtocol {
    
    
    public var loginDelegate: LoginViewControllerDelegate
    
    init(loginDelegate: LoginViewControllerDelegate) {
        self.loginDelegate = loginDelegate
    }
    
    enum State: Equatable {
        case initial //начальное состояние при загрузке
        case successExistUser //в случае успеха
        case successNewUser //
        case failureLogin (error: String)//если вход увенчался ошибкой
        case failureRegister (error: String) // если регистрация увенчалась ошибкой
        case noUser //если необходимо зарегистрировать нового пользователя
    }
    
    enum ViewInput {
        case loginButtonTapped (email: String, password: String)
        case newUserRegisterButtonPressed (email: String, password: String)
    }
    
    var onStateDidChange: ((State)-> Void)?
    
    var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState (viewInput: ViewInput) {
        
        switch viewInput {
            
        case let .loginButtonTapped(email: email, password: password):
            
            loginDelegate.checkCredentials(email: email, password: password) { authResult in
                switch authResult {
                    
                case .success:
                    self.state = .successExistUser
                
                case .failure(let error):
                    self.state = .failureLogin(error: error)
                    
                case .noUser:
                    self.state = .noUser
                    
                }
            }
            
        case let .newUserRegisterButtonPressed(email: email, password: password):
            
            loginDelegate.signUp(email: email, password: password) { signUpResault in
                switch signUpResault {
                    
                case .success:
                    self.state = .successNewUser
                
                case .failure(let error):
                    self.state = .failureRegister(error: error)
                }
            }
        }
    }
}


