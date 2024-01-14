//
//  RegistrationInteractor.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

protocol RegistrationInteractorProtocol: AnyObject {
    func register(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void))
    func checkIfUserAutorized() -> Bool
    func makeUserAutorized(token: String)
}

final class RegistrationInteractor: RegistrationInteractorProtocol {
    weak var presenter: RegistrationPresenterProtocol?
    var authService: AuthServiceProtocol
    var tokenService: TokenServiceProtocol
    
    init(authService: AuthServiceProtocol, tokenService: TokenServiceProtocol) {
        self.authService = authService
        self.tokenService = tokenService
    }
    
    func register(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void)) {
        authService.register(email: email, password: password) { result in
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
