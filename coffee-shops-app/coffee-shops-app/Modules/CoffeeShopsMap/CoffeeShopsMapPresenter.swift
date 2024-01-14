//
//  CoffeeShopsMapPresenter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol CoffeeShopsMapPresenterProtocol: AnyObject, MapObjectTapListenerDelegate {
    func viewDidLoaded()
}

final class CoffeeShopsMapPresenter: CoffeeShopsMapPresenterProtocol {
    let router: CoffeeShopsMapRouterProtocol
    let interactor: CoffeeShopsMapInteractorProtocol
    weak var view: CoffeeShopsMapViewProtocol?
    
    init(router: CoffeeShopsMapRouterProtocol, interactor: CoffeeShopsMapInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoaded() {
        view?.addAnnotations(with: interactor.getCoffeeShops())
    }
}
extension CoffeeShopsMapPresenter: MapObjectTapListenerDelegate {
    func mapWasTapped(latitude: Double, longitude: Double) {
        let id  = interactor.findClosestCoffeeShop(latitude: latitude, longitude: longitude)
        router.routeToCoffeeShopMenu(id: id)
    }
}
