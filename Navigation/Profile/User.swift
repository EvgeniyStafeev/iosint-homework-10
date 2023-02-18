//
//  User.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.01.2023.
//

import UIKit

protocol UserProtocol {
    func logIn(login: String, password: String) -> User?
}

class User {
    let login: String
    let password: String
    let fullName: String
    let statusLabel: String
    let avatar: UIImage
    init(login: String, password: String, fullName: String, statusLabel: String, avatar: UIImage) {
        self.login = login
        self.password = password
        self.fullName = fullName
        self.statusLabel = statusLabel
        self.avatar = avatar
    }
}
