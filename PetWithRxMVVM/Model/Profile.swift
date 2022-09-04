//
//  Profile.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 02.09.2022.
//

import Foundation

struct Profile: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let memes: [Meme]
}

struct Meme: Codable {
    let id: String?
    let name: String?
    let url: String?
}
