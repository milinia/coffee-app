//
//  RegistrationModuleBuilder.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import UIKit

final class RegistrationModuleBuilder {
    static func build(navigationController: UINavigationController) -> UIViewController {
        let interactor = RegistrationInteractor(authService: AuthService(),
                                         tokenService: TokenService(keychainService: KeychainService()))
        let router = RegistrationRouter(navigationController: navigationController)
        let presenter = RegistrationPresenter(router: router, interactor: interactor)
        let view = RegistrationView()
        
        view.presenter = presenter
        presenter.view = view
        router.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
