//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import UIKit

class LoginInspector: LoginViewControllerDelegate {
     let checker = Checker.self
     func check(login: String, password: String) -> Bool {
         if checker.shared.check(login: login, password: password) {
             print("Вход")
             return true
         } else {
             print("В доступе отказанно")
             return false
         }
     }
 }
