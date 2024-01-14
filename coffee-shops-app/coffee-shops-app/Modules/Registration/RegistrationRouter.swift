//
//  RegistrationRouter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

protocol RegistrationRouterProtocol: AnyObject {
    func routeToLogin()
    func routeToCoffeeShopsList()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    weak var presenter: RegistrationPresenterProtocol?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToLogin() {
        navigationController.popViewController(animated: true)
    }
    
    func routeToCoffeeShopsList() {
        let vc = CoffeeShopListModuleBuilder.build(navigationController: navigationController)
        navigationController.viewControllers = [vc]
    }
}
