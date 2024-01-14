//
//  CoffeeShopService.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Moya

protocol CoffeeShopServiceProtocol {
    func fetchCoffeeShops(token: String, completion: @escaping (Result<[CoffeeShopResponse], Error>) -> Void)
    func fetchCoffeeShopMenu(id: Int, token: String, completion: @escaping (Result<[MenuItem], Error>) -> Void)
}

final class CoffeeShopService: CoffeeShopServiceProtocol {
    
    var provider: MoyaProvider<CoffeeShopTarget> = MoyaProvider<CoffeeShopTarget>()
    
    struct BearerTokenPlugin: PluginType {
        let token: String

        func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            var request = request
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            return request
        }
    }
    
    func fetchCoffeeShops(token: String, completion: @escaping (Result<[CoffeeShopResponse], Error>) -> Void) {
        provider = MoyaProvider<CoffeeShopTarget>(plugins: [BearerTokenPlugin(token: token)])
        provider.request(.getCoffeeShops(token: token)) { result in
            switch result {
            case .failure(let error):
                switch error.errorCode {
                case 500:
                    completion(.failure(NetworkError.InternalServerError))
                case 401:
                    completion(.failure(NetworkError.UnauthorizedError))
                default:
                    completion(.failure(NetworkError.DefaultError))
                }
            case .success(let response):
                do {
                    let coffeeShops = try JSONDecoder().decode([CoffeeShopResponse].self, from: response.data)
                    completion(.success(coffeeShops))
                } catch {
                    completion(.failure(NetworkError.DecodingError))
                }
            }
        }
    }
    
    func fetchCoffeeShopMenu(id: Int, token: String, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        provider = MoyaProvider<CoffeeShopTarget>(plugins: [BearerTokenPlugin(token: token)])
        provider.request(.getCoffeeShopMenu(id: id, token: token)) { result in
            switch result {
            case .failure(let error):
                switch error.errorCode {
                case 500:
                    completion(.failure(NetworkError.InternalServerError))
                case 401:
                    completion(.failure(NetworkError.UnauthorizedError))
                default:
                    completion(.failure(NetworkError.DefaultError))
                }
            case .success(let response):
                do {
                    let menuItems = try JSONDecoder().decode([MenuItem].self, from: response.data)
                    completion(.success(menuItems))
                } catch {
                    completion(.failure(NetworkError.DecodingError))
                }
            }
        }
    }
}
