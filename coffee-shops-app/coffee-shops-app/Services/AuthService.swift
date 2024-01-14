//
//  AuthService.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Moya

protocol AuthServiceProtocol {
    func register(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void))
    func login(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void))
}

final class AuthService: AuthServiceProtocol {
    
    var provider: MoyaProvider<AuthTarget> = MoyaProvider<AuthTarget>()
    
    func register(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void)) {
        provider.request(.register(email: email, password: password)) { result in
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
                switch response.statusCode {
                    case 500:
                        completion(.failure(NetworkError.InternalServerError))
                    case 401:
                        completion(.failure(NetworkError.UnauthorizedError))
                    default:
                        do {
                            let authResult = try JSONDecoder().decode(AuthResponse.self, from: response.data)
                            completion(.success(authResult))
                        } catch {
                            completion(.failure(NetworkError.DecodingError))
                        }
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<AuthResponse, Error>) -> Void)) {
        provider.request(.login(email: email, password: password)) { result in
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
                switch response.statusCode {
                    case 500:
                        completion(.failure(NetworkError.InternalServerError))
                    case 401:
                        completion(.failure(NetworkError.UnauthorizedError))
                    default:
                        do {
                            let authResult = try JSONDecoder().decode(AuthResponse.self, from: response.data)
                            completion(.success(authResult))
                        } catch {
                            completion(.failure(NetworkError.DecodingError))
                        }
                }
            }
        }
    }
}
