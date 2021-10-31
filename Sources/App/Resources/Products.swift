//
//  Products.swift
//  
//
//  Created by Fabian Geistert on 31.10.21.
//

import Foundation

struct Products {
    static func getAll() -> [Product] {
        return [
            Product(
                id: UUID(uuidString: "73b20b48-ecbc-42ec-84f8-3b9207b839fb")!,
                name: "Käse 200g",
                price: "2.99"
            )
        ]
    }
}
