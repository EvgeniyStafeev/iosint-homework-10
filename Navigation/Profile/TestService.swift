//
//  TestService.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.01.2023.
//

import UIKit

class TestUserService: UserProtocol{
    public let testUser: User = User(login:"1111", password: "Qw2", fullName: "FullName", statusLabel: "Test", avatar: UIImage(named:"Фото5")!)
    
    func logIn(login: String, password: String) -> User? {
        guard login == testUser.login, password == testUser.password else {return nil}
        return testUser
    }
    
    init() {}
}
