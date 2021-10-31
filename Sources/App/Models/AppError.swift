//
//  File.swift
//  
//
//  Created by Fabian Geistert on 31.10.21.
//

import Foundation
import Vapor

enum AppError {
    case invalidRequest
    case failedToLoadProducts
    case productNotFound
    case internalError
}

extension AppError: AbortError {
    var reason: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request. Please provide productId and quantity. Coupon needs to be valid code."
        case .failedToLoadProducts:
            return "Failed to load products. Try again later."
        case .productNotFound:
            return "Product not found."
        case .internalError:
            return "Internal error."
        }
    }
    
    var status: HTTPStatus {
        switch self {
        case .invalidRequest:
            return .badRequest
        case .failedToLoadProducts:
            return .serviceUnavailable
        case .productNotFound:
            return .notFound
        case .internalError:
            return .internalServerError
        }
    }
}
