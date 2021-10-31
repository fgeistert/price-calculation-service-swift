import Vapor

func routes(_ app: Application) throws {
    app.get("price") { _ in
        return PriceResponse()
    }

    app.get("alive") { _ -> String in
        return "Alive!"
    }
}


