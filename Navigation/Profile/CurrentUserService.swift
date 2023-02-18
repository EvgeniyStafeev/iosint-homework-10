//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.01.2023.
//

import UIKit

class CurrentUserService: UserProtocol {
    var userNew: User = User(login: "1111", password: "Qw2", fullName: "Evgeny Stafeev", statusLabel: "Учусь в Нетологии", avatar: (UIImage(named: "Фото11")!))
    
    func logIn(login: String, password: String) -> User? {
        if login == userNew.login && password == userNew.password {
            print(userNew.avatar, userNew.fullName, userNew.login, userNew.password, userNew.statusLabel)
        }else{
            print("Данные не найдены")
        }
        return userNew
    }
    init() {}
}
