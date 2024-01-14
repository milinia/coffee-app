//
//  CoffeeShopsMapModuleBuilder.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

final class CoffeeShopsMapModuleBuilder {
    static func build(coffeeShops: [CoffeeShop], navigationController: UINavigationController) -> UIViewController {
        let interactor = CoffeeShopsMapInteractor(coffeeShops: coffeeShops)
        let router = CoffeeShopsMapRouter(navigationController: navigationController)
        let presenter = CoffeeShopsMapPresenter(router: router, interactor: interactor)
        let view = CoffeeShopsMapView()
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
