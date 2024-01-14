//
//  CoffeeShopListModuleBuilder.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

final class CoffeeShopListModuleBuilder {
    static func build(navigationController: UINavigationController) -> UIViewController {
        let interactor = CoffeeShopListInteractor(coffeeShopService: CoffeeShopService(),
                                                  tokenService: TokenService(keychainService: KeychainService()),
                                                  locationService: LocationService())
        let router = CoffeeShopListRouter(navigationController: navigationController)
        let presenter = CoffeeShopListPresenter(router: router, interactor: interactor)
        let view = CoffeeShopListView()
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
