//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by Александр Филатов on 03.09.2023.
//

import Foundation
import XCTest
@testable import Navigation
import FirebaseAuth
import FirebaseCore



class FeedViewModelTests: XCTestCase {
    
    func testVerifyEmptyField (){
        
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModel: feedModel)
        feedViewModel.updateState(viewInput: .checkButtonTapped(""))
        XCTAssertEqual(feedViewModel.state, .emptyField)
        
    }
    
    func testVerifySecretWordSuccess () {
        
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModel: feedModel)
        feedViewModel.updateState(viewInput: .checkButtonTapped("barcelona"))
        XCTAssertEqual(feedViewModel.state, .success)
        
    }
    
    func testVerifySecretWordFailure () {
        
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModel: feedModel)
        feedViewModel.updateState(viewInput: .checkButtonTapped("barcelo"))
        XCTAssertEqual(feedViewModel.state, .failure)
        
    }
    
    func testVerifyPostButtonTapped () {
        
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModel: feedModel)
        let coordinator = FeedModelTestingFake()
        feedViewModel.updateState(viewInput: .postButtonPTapped)
        
        if coordinator.event == .postButtonTapped {
            XCTAssertTrue(coordinator.funcPushPostViewControllerCalled)
        }
    }
 
    

    
}

class FeedModelTestingFake: FeedModelViewTesting {
    
    var event: Event?
    var funcPushPostViewControllerCalled = false
    
    func eventOccurred(event: Navigation.Event) {
        self.event = event
    }
    
    func pushPostViewController () {
        funcPushPostViewControllerCalled = true
    }
    
}
