//
//  AuthResponse.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Foundation

struct AuthResponse: Decodable {
    let token: String
    let tokenLifetime: Int
}
