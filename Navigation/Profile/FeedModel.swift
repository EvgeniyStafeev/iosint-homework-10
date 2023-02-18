//
//  FeedModel.swift
//  Navigation
//
//  Created by Евгений Стафеев on 05.02.2023.
//

import UIKit

struct FeedModel {
    private var secretWord: String = "1111"
    
    func check(word: String) -> Bool {
        if secretWord == word { return true }
        return false
    }
}
