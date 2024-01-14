//
//  CoffeeShopsMapRouter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

protocol CoffeeShopsMapRouterProtocol: AnyObject {
    func routeToCoffeeShopMenu(id: Int)
}

final class CoffeeShopsMapRouter: CoffeeShopsMapRouterProtocol {
    weak var presenter: CoffeeShopsMapPresenterProtocol?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToCoffeeShopMenu(id: Int) {
        let vc = MenuModuleBuilder.build(id: id, navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}
