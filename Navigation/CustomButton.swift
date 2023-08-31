//
//  CustomButton.swift
//  Navigation
//
//  Created by Александр Филатов on 26.04.2023.
//

import Foundation
import UIKit

public class CustomButton: UIButton {
    var completionHandler: (() -> Void)?
    init (title:String, radius:CGFloat, backColor:UIColor) {
        super.init(frame: CGRect())
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = radius
        self.backgroundColor = backColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func buttonTapped() {
        completionHandler?()
    }
}
