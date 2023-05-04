//
//  AppFactory.swift
//  Navigation
//
//  Created by Александр Филатов on 03.05.2023.
//

import UIKit

final class AppFactory {
    private let feedModel: FeedModel

    init(feedModel: FeedModel) {
        self.feedModel = feedModel
    }

    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        
        case .feed:
            let viewModel = FeedViewModel(feedModel: feedModel)
            let view = UINavigationController(rootViewController: FeedViewController(feedViewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        
        case .login:
            let loginVC = LogInViewController()
            loginVC.loginDelegate = MyLoginFactory().makeLoginInspector()
            let view = UINavigationController(rootViewController: loginVC)
            return Module(moduleType: moduleType, viewModel: nil, view: view)
        }
    }
}
