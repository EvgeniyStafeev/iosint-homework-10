//
//  Checker.swift
//  Navigation
//
//  Created by Евгений Стафеев on 27.01.2023.
//

import UIKit


final class Checker {

    private let login = "1111"
    private let password = "Qw2"


    static let shared = Checker()

    private init() {}
    
}

extension Checker: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        self.login == login && password == password
    }
}
