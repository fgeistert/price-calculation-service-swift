@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    func testAlive() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "alive", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Alive!")
        })
    }
    
    func testPriceEndpointWithoutParameters() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "price", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
    }
    
    func testPriceEndpointWithInvalidUUID() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "price?productId=1", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
    }
    
    func testPriceEndpointWithInvalidQuantity() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "price?productId=73b20b48-ecbc-42ec-84f8-3b9207b839fb&quantity=a", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
    }
    
    func testPriceEndpointWithInvalidCoupon() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "price?productId=73b20b48-ecbc-42ec-84f8-3b9207b839fb&quantity=1&coupon=INVALID", afterResponse: { res in
            XCTAssertEqual(res.status, .badRequest)
        })
    }
    
    func testPriceEndpointWithValidParameters() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "price?productId=73b20b48-ecbc-42ec-84f8-3b9207b839fb&quantity=1&coupon=FIVE", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
    
    func testProductNotFoundError() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "price?productId=73b20b48-ecbc-42ec-84f8-3b9207b839fa&quantity=1&coupon=FIVE", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
}
