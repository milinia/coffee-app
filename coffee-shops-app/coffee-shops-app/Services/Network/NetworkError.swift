//
//  NetworkError.swift
//  coffee-shops-app
//
//  Created by Evelina on 13.01.2024.
//

import Foundation

enum NetworkError: Error {
    case UnauthorizedError
    case InternalServerError
    case DefaultError
    case DecodingError
    
    var description: String {
        switch self {
        case .UnauthorizedError:
            return "Token is not valid or has expired"
        case .InternalServerError:
            return "Server error"
        case .DefaultError:
            return "Something went wrong"
        case .DecodingError:
            return "Uncorrect response data"
        }
    }
}
