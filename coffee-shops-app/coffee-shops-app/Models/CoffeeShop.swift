//
//  CoffeeShop.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Foundation

struct CoffeeShopResponse: Decodable {
    let id: Int
    let name: String
    let point: Location
}

struct Location: Decodable {
    let latitude: String
    let longitude: String
}

struct CoffeeShop {
    let coffeeShop: CoffeeShopResponse
    let distanceFromUser: Int
}
