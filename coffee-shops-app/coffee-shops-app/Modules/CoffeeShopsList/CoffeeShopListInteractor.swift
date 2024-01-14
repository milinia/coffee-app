//
//  CoffeeShopListInteractor.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol CoffeeShopListInteractorProtocol: AnyObject {
    func loadCoffeeShops(completion: @escaping ((Result<[CoffeeShop], Error>) -> Void))
}

final class CoffeeShopListInteractor: CoffeeShopListInteractorProtocol {
    weak var presenter: CoffeeShopListPresenter?
    let coffeeShopService: CoffeeShopServiceProtocol
    let tokenService: TokenServiceProtocol
    let locationService: LocationServiceProtocol
    
    private var coffeeShops: [CoffeeShop] = []
    
    init(coffeeShopService: CoffeeShopServiceProtocol, tokenService: TokenServiceProtocol, locationService: LocationServiceProtocol) {
        self.coffeeShopService = coffeeShopService
        self.tokenService = tokenService
        self.locationService = locationService
    }
    
    func loadCoffeeShops(completion: @escaping ((Result<[CoffeeShop], Error>) -> Void)) {
        if let token = tokenService.getToken() {
            coffeeShopService.fetchCoffeeShops(token: token) { result in
                switch result {
                case .success(let success):
                    let coffeeShopsResponse = success
                    let coffeeShops: [CoffeeShop] = coffeeShopsResponse.map { shop in
                        CoffeeShop(coffeeShop: shop,
                                   distanceFromUser: self.locationService.distanceFrom(latitude: Double(shop.point.latitude) ?? 0,
                                                                                  longitude: Double(shop.point.longitude) ?? 0))
                    }
                    completion(.success(coffeeShops))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
