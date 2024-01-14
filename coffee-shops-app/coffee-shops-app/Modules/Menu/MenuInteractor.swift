//
//  MenuInteractor.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol MenuInteractorProtocol: AnyObject {
    func loadCoffeeShopMenu(completion: @escaping ((Result<[MenuItem], Error>) -> Void))
    func increaseProductAmount(product: MenuItem)
    func decreaseProductAmount(product: MenuItem)
    func getChoosedProducts() -> [OrderItem]
}

final class MenuInteractor: MenuInteractorProtocol {
    weak var presenter: MenuPresenterProtocol?
    let coffeeShopService: CoffeeShopServiceProtocol
    let tokenService: TokenServiceProtocol
    let id: Int
    private var menu: [MenuItem] = []
    private var choosedProducts: [OrderItem] = []
    
    init(id: Int, coffeeShopService: CoffeeShopServiceProtocol, tokenService: TokenServiceProtocol) {
        self.id = id
        self.coffeeShopService = coffeeShopService
        self.tokenService = tokenService
    }
    
    func loadCoffeeShopMenu(completion: @escaping ((Result<[MenuItem], Error>) -> Void)) {
        if let token = tokenService.getToken() {
            coffeeShopService.fetchCoffeeShopMenu(id: id, token: token) { result in
                completion(result)
            }
        }
    }
    
    func increaseProductAmount(product: MenuItem) {
        if let index = choosedProducts.firstIndex(where: { $0.product.id == product.id }) {
            choosedProducts[index].amount += 1
        } else {
            choosedProducts.append(OrderItem(product: product, amount: 1))
        }
    }
    
    func decreaseProductAmount(product: MenuItem) {
        if let index = choosedProducts.firstIndex(where: { $0.product.id == product.id }) {
            if choosedProducts[index].amount == 0 {
                choosedProducts.remove(at: index)
            } else {
                choosedProducts[index].amount -= 1
            }
        }
    }
    
    func getChoosedProducts() -> [OrderItem] {
        return choosedProducts
    }
}

