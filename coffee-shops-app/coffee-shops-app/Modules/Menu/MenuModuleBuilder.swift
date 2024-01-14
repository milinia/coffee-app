//
//  MenuModuleBuilder.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

final class MenuModuleBuilder {
    static func build(id: Int, navigationController: UINavigationController) -> UIViewController {
        let interactor = MenuInteractor(id: id,
                                        coffeeShopService: CoffeeShopService(),
                                        tokenService: TokenService(keychainService: KeychainService()))
        let router = MenuRouter(navigationController: navigationController)
        let presenter = MenuPresenter(router: router, interactor: interactor)
        let view = MenuView()
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
