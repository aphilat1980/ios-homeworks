//
//  Module.swift
//  Navigation
//
//  Created by Александр Филатов on 03.05.2023.
//

import Foundation
import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    enum ModuleType {
        case feed
        case login
    }

    let moduleType: ModuleType
    let viewModel: ViewModelProtocol?
    let view: UIViewController
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .feed:
            let title = NSLocalizedString("feedTabBarTitle", comment: "")
            return UITabBarItem(title: title, image: UIImage(systemName: "book.fill"), tag: 0)
        case .login:
            let title = NSLocalizedString("profileTabBarTitle", comment: "")
            return UITabBarItem(title: title, image: UIImage(systemName: "person.fill"), tag: 1)
        }
    }
}
