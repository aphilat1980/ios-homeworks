//
//  LoginViewModelTests.swift
//  NavigationTests
//
//  Created by Александр Филатов on 03.09.2023.
//

import Foundation
import XCTest
@testable import Navigation
import FirebaseAuth
import FirebaseCore

class LoginViewModelTests: XCTestCase {
    
    func testVerifySuccessExistUser (){
        
        let loginDelegate = loginModelTestingFake()
        let loginViewModel = LoginViewModel(loginDelegate: loginDelegate)
        loginDelegate.authResult = .success
        loginViewModel.updateState(viewInput: .loginButtonTapped(email: "aphilat@mail.ru", password: "123456"))
        XCTAssertEqual(loginViewModel.state, .successExistUser)
    
    }
    
    func testVerifyFailureExistUser (){
        
        let loginDelegate = loginModelTestingFake()
        let loginViewModel = LoginViewModel(loginDelegate: loginDelegate)
        loginDelegate.authResult = .failure("error")
        loginViewModel.updateState(viewInput: .loginButtonTapped(email: "mail.r", password: "12345"))
        XCTAssertEqual(loginViewModel.state, .failureLogin(error: "error"))
    
    }
    
    func testVerifyNoUser (){
        
        let loginDelegate = loginModelTestingFake()
        let loginViewModel = LoginViewModel(loginDelegate: loginDelegate)
        loginDelegate.authResult = .noUser
        loginViewModel.updateState(viewInput: .loginButtonTapped(email: "aphilat@mail.r", password: "12345"))
        XCTAssertEqual(loginViewModel.state, .noUser)
    }
    
    func testVerifySuccessNewUserRegister (){
        
        let loginDelegate = loginModelTestingFake()
        let loginViewModel = LoginViewModel(loginDelegate: loginDelegate)
        loginDelegate.sighUpResult = .success
        loginViewModel.updateState(viewInput: .newUserRegisterButtonPressed(email: "aphilat@mail.r", password: "12345"))
        XCTAssertEqual(loginViewModel.state, .successNewUser)
    }
    
    func testVerifyFailureNewUserRegister (){
        
        let loginDelegate = loginModelTestingFake()
        let loginViewModel = LoginViewModel(loginDelegate: loginDelegate)
        loginDelegate.sighUpResult = .failure("error")
        loginViewModel.updateState(viewInput: .newUserRegisterButtonPressed(email: "aphilat@mail.r", password: "12345"))
        XCTAssertEqual(loginViewModel.state, .failureRegister(error: "error"))
    }
    
    
}

class loginModelTestingFake: LoginViewControllerDelegate {
    
    func check(checker: Navigation.Checker, user: String, password: String) -> Bool {
        return true
    }
    
    var authResult: AuthResult?
    var sighUpResult: SighUpResult?
    
    func checkCredentials(email: String, password: String, completion: @escaping (AuthResult) -> Void) {
        completion(authResult!)
        
    }
    
    func signUp(email: String, password: String, completion: @escaping (Navigation.SighUpResult) -> Void) {
        
        completion(sighUpResult!)
    }
}
