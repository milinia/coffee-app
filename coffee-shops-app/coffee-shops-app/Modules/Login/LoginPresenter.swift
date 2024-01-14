//
//  LoginPresenter.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func login(email: String, password: String)
    func openRegisterScreen()
}

final class LoginPresenter: LoginPresenterProtocol {
    let router: LoginRouterProtocol
    let interactor: LoginInteractorProtocol
    weak var view: LoginViewProtocol?
    
    init(router: LoginRouterProtocol, interactor: LoginInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func login(email: String, password: String) {
        interactor.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResponse):
                self?.interactor.makeUserAutorized(token: authResponse.token)
                self?.router.routeToCoffeeShopsList()
            case .failure(_): break
            }
        }
    }
    
    func openRegisterScreen() {
        router.routeToRegister()
    }
}
