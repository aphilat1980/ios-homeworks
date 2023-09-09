//
//  Pallete.swift
//  Navigation
//
//  Created by Александр Филатов on 02.09.2023.
//

import Foundation
import UIKit

struct Pallete {
    
    static var viewControllerBackgroundColor: UIColor = {
        UIColor.createColor(lightMode: .white, darkMode: .black)
    }()
    
    static var textFieldBackgroundColor: UIColor = {
        UIColor.createColor(lightMode: .systemGray6, darkMode: .darkGray)
    }()
    
    static var standartColor: UIColor = {
        UIColor.createColor(lightMode: .black, darkMode: .white)
    }()
    
    static var secondaryTextColor: UIColor = {
        UIColor.createColor(lightMode: .gray, darkMode: .systemGray)
    }()
    
    static var imageBackgroundColor: UIColor = {
        UIColor.createColor(lightMode: .black, darkMode: .systemGray4)
    }()
}


extension UIColor {
    static func createColor (lightMode:UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
