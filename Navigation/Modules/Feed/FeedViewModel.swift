//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Александр Филатов on 26.04.2023.
//

import Foundation
import UIKit

class FeedViewModel:ViewModelProtocol, Coordinating {
    
    weak var coordinator: ModuleCoordinatable?
    
    enum State {
        case initial //начальное состояние при загрузке
        case success //в случае успешной проверки
        case failure //если проверка секретного слова не увенчалась успехом
        case emptyField //если передана для проверки пустая строка
    }
    
    enum ViewInput {
        case checkButtonTapped (String)
        case postButtonPTapped
    }
    
    //замыкание для передачи состояния модели во view
    var onStateDidChange: ((State)-> Void)?
    
    var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    var feedModel: FeedModel
    
    init(feedModel: FeedModel) {
        self.feedModel = feedModel
    }
    
    //метод проверки секретного слова модели при передаче данных из view
    func updateState (viewInput: ViewInput) {
        switch viewInput {
        case let .checkButtonTapped(secretWord):
            if secretWord == "" {
                state = .emptyField
            } else {
                feedModel.secretWord == secretWord ? (state = .success): (state = .failure)
            }
        case .postButtonPTapped:
            
            (coordinator as? FeedCoordinator)?.eventOccurred(event: .postButtonTapped)
        }
    }
}
