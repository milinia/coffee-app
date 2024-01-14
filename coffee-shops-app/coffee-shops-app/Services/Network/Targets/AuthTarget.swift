//
//  AuthTarget.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Moya

enum AuthTarget {
    case login(email: String, password: String)
    case register(email: String, password: String)
}

extension AuthTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210/")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let email, let password), .register(let email, let password):
            let parameters: [String: Any] = [
                "login": email,
                "password": password
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
}
