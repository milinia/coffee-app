//
//  CoffeeShopsMapInteractor.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol CoffeeShopsMapInteractorProtocol: AnyObject {
    func getCoffeeShops() -> [CoffeeShop]
    func findClosestCoffeeShop(latitude: Double, longitude: Double) -> Int 
}

final class CoffeeShopsMapInteractor: CoffeeShopsMapInteractorProtocol {
    weak var presenter: CoffeeShopsMapPresenterProtocol?
    
    private var coffeeShops: [CoffeeShop]
    
    init(coffeeShops: [CoffeeShop]) {
        self.coffeeShops = coffeeShops
    }
    
    func getCoffeeShops() -> [CoffeeShop] {
        return coffeeShops
    }
    
    func findClosestCoffeeShop(latitude: Double, longitude: Double) -> Int {
        var minDistance: Double = Double.infinity
        var nearestCoffeeShop: CoffeeShop?
        
        for shop in coffeeShops {
            let distance = calculateDistance(lat1: latitude, lon1: longitude,
                                             lat2: Double(shop.coffeeShop.point.latitude) ?? 0,
                                             lon2: Double(shop.coffeeShop.point.longitude) ?? 0)

            if distance <= minDistance {
                minDistance = distance
                nearestCoffeeShop = shop
            }
        }
        
        return nearestCoffeeShop?.coffeeShop.id ?? 0
    }
    
    private func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let R = 6371.0

        let dLat = toRadians(value: (lat2 - lat1))
        let dLon = toRadians(value: (lon2 - lon1))
        
        let a1 = sin(dLat / 2)
        let a2 = sin(dLon / 2)

        let a = a1 * a1 + cos(toRadians(value: lat1)) * cos(toRadians(value: lat2)) * a2 * a2
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        let distance = R * c

        return distance
    }
    
    private func toRadians(value: Double) -> Double {
        return value * .pi / 180.0
    }
}
