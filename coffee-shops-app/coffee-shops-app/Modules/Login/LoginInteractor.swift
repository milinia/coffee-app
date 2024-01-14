//
//  LoginInteractor.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func login(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void))
    func checkIfUserAutorized() -> Bool
    func makeUserAutorized(token: String)
}

final class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol?
    var authService: AuthServiceProtocol
    var tokenService: TokenServiceProtocol
    
    init(authService: AuthServiceProtocol, tokenService: TokenServiceProtocol) {
        self.authService = authService
        self.tokenService = tokenService
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void)) {
        authService.login(email: email, password: password) { result in
            completion(result)
        }
    }
    
    func checkIfUserAutorized() -> Bool {
        return tokenService.isAutorized()
    }
    
    func makeUserAutorized(token: String) {
        tokenService.makeAutorized(token: token)
    }
}
