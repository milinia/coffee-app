//
//  OrderRouter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

protocol OrderRouterProtocol: AnyObject {
    func routeToCoffeeShopList()
}

final class OrderRouter: OrderRouterProtocol {
    weak var presenter: OrderPresenterProtocol?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToCoffeeShopList() {
        navigationController.popToRootViewController(animated: true)
    }
}
