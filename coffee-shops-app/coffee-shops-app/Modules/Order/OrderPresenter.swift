//
//  OrderPresenter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol OrderPresenterProtocol: AnyObject {
    func openCoffeeShopListScreen()
}

final class OrderPresenter: OrderPresenterProtocol {
    let router: OrderRouterProtocol
    let interactor: OrderInteractorProtocol
    weak var view: OrderViewProtocol?
    
    init(router: OrderRouterProtocol, interactor: OrderInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func openCoffeeShopListScreen() {
        router.routeToCoffeeShopList()
    }
}
