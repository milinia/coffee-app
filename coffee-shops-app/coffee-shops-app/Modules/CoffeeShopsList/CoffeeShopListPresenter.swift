//
//  CoffeeShopListPresenter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol CoffeeShopListPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func coffeeShopsDidLoad(coffeeShops: [CoffeeShop])
    func openMapScreen(coffeeShops: [CoffeeShop])
    func openMenuScreen(index: Int)
}

final class CoffeeShopListPresenter: CoffeeShopListPresenterProtocol {
    let router: CoffeeShopListRouterProtocol
    let interactor: CoffeeShopListInteractorProtocol
    weak var view: CoffeeShopListViewProtocol?
    
    init(router: CoffeeShopListRouterProtocol, interactor: CoffeeShopListInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoaded() {
        interactor.loadCoffeeShops { [weak self] result in
            switch result {
            case .success(let coffeeShops):
                self?.view?.updateCollectionView(with: coffeeShops)
            case .failure(_):
                break
            }
        }
    }
    
    func coffeeShopsDidLoad(coffeeShops: [CoffeeShop]) {
        view?.updateCollectionView(with: coffeeShops)
    }
    
    func openMapScreen(coffeeShops: [CoffeeShop]) {
        router.routeToCoffeeShopMap(coffeeShops: coffeeShops)
    }
    
    func openMenuScreen(index: Int) {
        router.routeToCoffeeShopMenu(id: index)
    }
}
