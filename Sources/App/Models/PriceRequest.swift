//
//  File.swift
//  
//
//  Created by Fabian Geistert on 31.10.21.
//

import Foundation

struct PriceRequest: Codable {
    let productId: UUID
    let quantity: Int
    let coupon: Coupon?
}
