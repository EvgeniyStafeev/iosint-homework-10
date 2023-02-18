//
//  Service.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
     func check(login: String, password: String) -> Bool
 }

 protocol LoginFactory {
     func makeLoginInspector() -> LoginInspector
 }

 struct MyLoginFactory: LoginFactory {
     func makeLoginInspector() -> LoginInspector {
         LoginInspector()
     }
 }
