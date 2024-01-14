//
//  LoginModuleBuilder.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import UIKit

final class LoginModuleBuilder {
    static func build(navigationController: UINavigationController) -> UIViewController {
        let interactor = LoginInteractor(authService: AuthService(),
                                         tokenService: TokenService(keychainService: KeychainService()))
        let router = LoginRouter(navigationController: navigationController)
        let presenter = LoginPresenter(router: router, interactor: interactor)
        let view = LoginView()
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
