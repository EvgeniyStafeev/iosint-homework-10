//
//  Photo.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.11.2022.
//

import UIKit

struct Photo {
  
  let author: String
  let image: String
 
    static func makeMockModel() -> [Photo] {
        var photo = [Photo]()
        photo.append(Photo(author: "В мире природы", image: "Фото1"))
        photo.append(Photo(author: "Крутые авто", image: "Фото2"))
        photo.append(Photo(author: "Кондитерская на Ленина", image: "Фото3"))
        photo.append(Photo(author: "Путешествия", image: "Фото4"))
        photo.append(Photo(author: "Драконы 3000", image: "Фото5"))
        photo.append(Photo(author: "Крутые Авто", image: "Фото6"))
        photo.append(Photo(author: "Путешествия", image: "Фото7"))
        photo.append(Photo(author: "Путешествия", image: "Фото8"))
        photo.append(Photo(author: "Мотоспорт", image: "Фото9"))
        photo.append(Photo(author: "Мотоспорт", image: "Фото11"))
        photo.append(Photo(author: "Картины", image: "Фото12"))
        photo.append(Photo(author: "Картины", image: "Фото13"))
        photo.append(Photo(author: "Путешествия", image: "Фото14"))
        return photo
    }
}
