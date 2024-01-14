//
//  OrderInteractor.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol OrderInteractorProtocol: AnyObject {
    
}

final class OrderInteractor: OrderInteractorProtocol {
    weak var presenter: OrderPresenterProtocol?
    
    private var coffeeShops: [CoffeeShop] = []
}
