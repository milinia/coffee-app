//
//  CoffeeShopListRouter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

protocol CoffeeShopListRouterProtocol: AnyObject {
    func routeToCoffeeShopMap(coffeeShops: [CoffeeShop])
    func routeToCoffeeShopMenu(id: Int)
}

final class CoffeeShopListRouter: CoffeeShopListRouterProtocol {
    weak var presenter: CoffeeShopListPresenterProtocol?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToCoffeeShopMap(coffeeShops: [CoffeeShop]) {
        let vc = CoffeeShopsMapModuleBuilder.build(coffeeShops: coffeeShops, navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToCoffeeShopMenu(id: Int) {
        let vc = MenuModuleBuilder.build(id: id, navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
