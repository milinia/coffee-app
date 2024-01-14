//
//  OrderModuleBuilder.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

final class OrderModuleBuilder {
    static func build(order: [OrderItem], navigationController: UINavigationController) -> UIViewController {
        let interactor = OrderInteractor()
        let router = OrderRouter(navigationController: navigationController)
        let presenter = OrderPresenter(router: router, interactor: interactor)
        let view = OrderView(order: order)
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
