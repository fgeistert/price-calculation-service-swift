//
//  File.swift
//  
//
//  Created by Fabian Geistert on 31.10.21.
//

import Foundation

struct ProductQuantityCalculator {
    
    static func calculate(product: Product, quantity: Int, coupon: Coupon?) -> Result<String, AppError> {
        guard let singlePrice = Double(product.price) else { return .failure(.internalError) }
        let totalPrice = singlePrice * Double(quantity)
        var finalPrice = totalPrice
        
        if let coupon = coupon {
            switch coupon {
            case .fivePercent:
                finalPrice = totalPrice * 0.95
            case .tenPercent:
                finalPrice = totalPrice * 0.9
            }
        }
        
        return .success(String(format: "%.2f", finalPrice))
    }
}
