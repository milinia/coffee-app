//
//  MenuRouter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

protocol MenuRouterProtocol: AnyObject {
    func routeToOrderScreen(order: [OrderItem])
}

final class MenuRouter: MenuRouterProtocol {
    weak var presenter: MenuPresenterProtocol?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToOrderScreen(order: [OrderItem]) {
        let vc = OrderModuleBuilder.build(order: order, navigationController: navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
