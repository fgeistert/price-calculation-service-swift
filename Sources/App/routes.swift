import Vapor

func routes(_ app: Application) throws {
    app.get("price") { _ in
        return PriceResponse()
    }
    
    app.get("products") { request -> String in
        let encoder = try! JSONEncoder().encode(Products.getAll())
        return String(data: encoder, encoding: .utf8)!
    }

    app.get("alive") { _ -> String in
        return "Alive!"
    }
}
