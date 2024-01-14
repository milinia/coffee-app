//
//  CoffeeShopTarget.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import Moya

enum CoffeeShopTarget {
    case getCoffeeShops(token: String)
    case getCoffeeShopMenu(id: Int, token: String)
}

extension CoffeeShopTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .getCoffeeShops:
            return "/locations"
        case .getCoffeeShopMenu(let id, _):
            return "/location/\(id)/menu"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return .none
    }
}
