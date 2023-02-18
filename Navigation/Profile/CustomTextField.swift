//
//  CustomTextField.swift
//  Navigation
//
//  Created by Евгений Стафеев on 05.02.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    init(font: UIFont, placeholder: String, borderColor: CGColor, borderWidth: CGFloat) {
        super.init(frame: .zero)
        self.font = font
        self.placeholder = placeholder
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.translatesAutoresizingMaskIntoConstraints = false
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
