//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Александр Филатов on 03.05.2023.
//

import Foundation
import UIKit

final class LoginCoordinator: ModuleCoordinatable {
    
    enum Event {
        case loginButtonTapped (User)
        case photosTapped
    }
    
    
    let moduleType: Module.ModuleType

    private let factory: AppFactory

    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?

    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }

    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        ((module.view as? UINavigationController)?.viewControllers[0] as? LogInViewController)?.coordinator = self
        self.module = module
        return viewController
    }

    func eventOccurred (event: Event ) {
        switch event {
        
        case let .loginButtonTapped(user):
            let viewControllerToPush: ProfileViewController & Coordinating = ProfileViewController(user: user)
            viewControllerToPush.coordinator = self
            (module?.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
        
        case .photosTapped:
            let photosViewController = PhotosViewController()
            (module?.view as? UINavigationController)?.pushViewController(photosViewController, animated: true)
        }
    }
    
}
