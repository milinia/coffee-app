//
//  TokenService.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Foundation

protocol TokenServiceProtocol {
    func isAutorized() -> Bool
    func makeAutorized(token: String) -> Bool
    func getToken() -> String?
}

final class TokenService: TokenServiceProtocol {
    
    private var keychainService: KeychainServiceProtocol
    
    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }
    
    private func checkToken() -> String? {
        if let token = keychainService.getValue(service: "CoffeeShop-App", account: "User") {
            return String(data: token, encoding: .utf8) ?? ""
        } else {
            return nil
        }
    }
    
    private func setToken(token: String) -> Bool {
        return keychainService.setValue(service: "CoffeeShop-App", account: "User", value: token.data(using: .utf8) ?? Data())
    }
    
    func isAutorized() -> Bool {
        if let result = checkToken() {
            return result.isEmpty
        } else {
            return false
        }
    }
    
    func makeAutorized(token: String) -> Bool {
        return setToken(token: token)
    }
    
    func getToken() -> String? {
        return checkToken()
    }
}
