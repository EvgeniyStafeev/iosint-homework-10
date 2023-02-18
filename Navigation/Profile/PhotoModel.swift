//
//  PhotoModel.swift
//  Navigation
//
//  Created by Евгений Стафеев on 02.02.2023.
//

import UIKit

struct PhotoModel {
    static func makeModel() -> [UIImage]? {
        var model = [UIImage]()
        for element in 1...20 {
            guard let image = UIImage(named: "фото\(element)") else { return nil }
            model.append(image)
        }
        return model
    }
}
