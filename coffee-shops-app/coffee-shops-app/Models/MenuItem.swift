//
//  MenuItem.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Foundation

struct MenuItem: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Int
}
