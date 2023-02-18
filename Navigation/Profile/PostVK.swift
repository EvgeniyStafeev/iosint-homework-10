//
//  Post.swift
//  Navigation
//
//  Created by Евгений Стафеев on 18.11.2022.
//

import UIKit

struct PostVK {
    let author: String
    let description: String
    let image: String
    let like: Int
    let view: Int
    
    static func makePost() -> [PostVK] {
        var model = [PostVK]()
        
        model.append(PostVK(author: "В Мире Животных", description: "Котик", image: "krasivye-kartinki-kotov-31", like: 2, view: 12))
        model.append(PostVK(author: "Ждун", description: "Ждун-Ждуныч", image: "5631", like: 231, view: 12345))
        
        return model
    }
}
