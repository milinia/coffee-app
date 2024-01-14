//
//  LoginRouter.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import UIKit

protocol LoginRouterProtocol: AnyObject {
    func routeToRegister()
    func routeToCoffeeShopsList()
}

final class LoginRouter: LoginRouterProtocol {
    weak var presenter: LoginPresenterProtocol?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToRegister() {
        let vc = RegistrationModuleBuilder.build(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToCoffeeShopsList() {
        let vc = CoffeeShopListModuleBuilder.build(navigationController: navigationController)
        navigationController.viewControllers = [vc]
    }
}
