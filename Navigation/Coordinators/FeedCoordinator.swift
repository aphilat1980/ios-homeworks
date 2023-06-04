//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Александр Филатов on 03.05.2023.
//
import UIKit

enum Event {
    case postButtonTapped
    case infoButtonTapped
}

final class FeedCoordinator: ModuleCoordinatable {
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory

    private(set) var module: Module?
    private(set) var childCoordinators: [Coordinatable] = []

    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }

    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? FeedViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func eventOccurred (event: Event) {
        switch event {
        
        case .postButtonTapped:
            let viewControllerToPush: PostViewController & Coordinating = PostViewController()
            viewControllerToPush.coordinator = self
            (module?.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
        
        case .infoButtonTapped:
            let infoViewController = InfoViewController()
            infoViewController.modalTransitionStyle = .coverVertical
            infoViewController.modalPresentationStyle = .pageSheet
            (module?.view as? UIViewController)?.present(infoViewController, animated: true)
        }
    }
    
}
