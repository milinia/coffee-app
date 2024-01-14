//
//  RegistrationPresenter.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func register(email: String, password: String)
    func openLoginScreen()
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    let router: RegistrationRouterProtocol
    let interactor: RegistrationInteractorProtocol
    weak var view: RegistrationViewProtocol?
    
    init(router: RegistrationRouterProtocol, interactor: RegistrationInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func register(email: String, password: String) {
        interactor.register(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResponse):
                self?.interactor.makeUserAutorized(token: authResponse.token)
                self?.router.routeToCoffeeShopsList()
            case .failure(_): break
            }
        }
    }
    
    func openLoginScreen() {
        router.routeToLogin()
    }
}
