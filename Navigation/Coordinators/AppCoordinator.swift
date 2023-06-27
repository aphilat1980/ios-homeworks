//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Александр Филатов on 03.05.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    private(set) var childCoordinators: [Coordinatable] = []

    private let factory: AppFactory

    init(factory: AppFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator(moduleType: .feed, factory: factory)
        let loginCoordinator = LoginCoordinator(moduleType: .login, factory: factory)
        let savedPostViewController = SavedPostViewController()
        savedPostViewController.tabBarItem = UITabBarItem(title: "Saved Posts", image: UIImage(systemName: "square.and.arrow.down"), tag: 2)

       
        /*let appTabBarController = AppTabBarController(viewControllers: [
            booksListCoordinator.start(),
            aboutCoordinator.start()
        ])*/
        let appTabBarController = UITabBarController()
        appTabBarController.tabBar.backgroundColor = .systemGray6
        appTabBarController.viewControllers = [feedCoordinator.start(), loginCoordinator.start(), UINavigationController(rootViewController: savedPostViewController)]

        addChildCoordinator(feedCoordinator)
        addChildCoordinator(loginCoordinator)

        return appTabBarController
    }

    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 === coordinator }
    }
}
