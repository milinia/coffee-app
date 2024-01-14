//
//  MenuPresenter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol MenuPresenterProtocol: AnyObject, ProductCellDelegate {
    func viewDidLoaded()
    func openOrderScreen(order: [OrderItem])
}

final class MenuPresenter: MenuPresenterProtocol {
    let router: MenuRouterProtocol
    let interactor: MenuInteractorProtocol
    weak var view: MenuViewProtocol?
    
    init(router: MenuRouterProtocol, interactor: MenuInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoaded() {
        interactor.loadCoffeeShopMenu() { [weak self] result in
            switch result {
            case .success(let menu):
                self?.view?.updateCollectionView(with: menu)
            case .failure(_):
                break
            }
        }
    }
    
    func openOrderScreen(order: [OrderItem]) {
        if !(interactor.getChoosedProducts().isEmpty) {
            router.routeToOrderScreen(order: interactor.getChoosedProducts())
        }
    }
}
extension MenuPresenter: ProductCellDelegate {
    func increaseAmount(product: MenuItem) {
        interactor.increaseProductAmount(product: product)
    }
    
    func deсreaseAmount(product: MenuItem) {
        interactor.decreaseProductAmount(product: product)
    }
}
