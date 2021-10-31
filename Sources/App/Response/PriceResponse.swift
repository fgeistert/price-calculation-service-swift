//
//  File.swift
//  
//
//  Created by Fabian Geistert on 31.10.21.
//

import Foundation
import Vapor

struct PriceResponse: ResponseEncodable {
    func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        guard let productsURL = Bundle.module.url(forResource: "products", withExtension: "json"),
              let productsData = try? Data(contentsOf: productsURL),
              let products = try? JSONDecoder().decode([Product].self, from: productsData)
        else {
            return request.eventLoop.makeFailedFuture(AppError.failedToLoadProducts)
        }
        
        guard let priceRequest = try? request.query.decode(PriceRequest.self) else {
            return request.eventLoop.makeFailedFuture(AppError.invalidRequest)
        }
        
        guard let requestedProduct = products.first(where: { $0.id == priceRequest.productId }) else {
            return request.eventLoop.makeFailedFuture(AppError.productNotFound)
        }
        
        var responseHeaders = HTTPHeaders()
        responseHeaders.add(name: .contentType, value: "text/json")
        
        let responsePrice = ProductQuantityCalculator.calculate(product: requestedProduct, quantity: priceRequest.quantity, coupon: priceRequest.coupon)
        
        switch responsePrice {
        case .failure(let error):
            return request.eventLoop.makeFailedFuture(error)
        case .success(let price):
            return request.eventLoop.makeSucceededFuture(
                .init(
                    status: .ok,
                    headers: responseHeaders,
                    body: .init(string: price)
                )
            )
        }
    }
}
