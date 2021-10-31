//
//  ProductQuantityCalculatorTests.swift
//  
//
//  Created by Fabian Geistert on 31.10.21.
//

@testable import App
import XCTVapor

final class ProductQuantityCalculatorTests: XCTestCase {
    func testSingleProduct() throws {
        let product = Product(id: UUID(), name: "Test Product 1", price: "1.99")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 1, coupon: nil)
        
        guard case .success(let result) = calculatorResult else {
            XCTFail("Calculation failed")
            return
        }
        
        XCTAssertTrue(result == "1.99", "with a quantity of 1, the result should be equal to single price")
    }
    
    func testMultipleProducts() throws {
        let product = Product(id: UUID(), name: "Test Product 1", price: "1.99")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 5, coupon: nil)
        
        guard case .success(let result) = calculatorResult else {
            XCTFail("Calculation failed")
            return
        }
        
        XCTAssertTrue(result == "9.95", "with a quantity of 5, the result should be equal to the price * 5")
    }
    
    func testSingleProductWithCouponFive() throws {
        let product = Product(id: UUID(), name: "Test Product 1", price: "1.99")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 1, coupon: .fivePercent)
        
        guard case .success(let result) = calculatorResult else {
            XCTFail("Calculation failed")
            return
        }
        
        XCTAssertTrue(result == "1.89", "with a quantity of 1 and coupon FIVE, the result should be equal to single price minus 5%")
    }
    
    func testMultipleProductsWithCouponFive() throws {
        let product = Product(id: UUID(), name: "Test Product 1", price: "1.99")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 5, coupon: .fivePercent)
        
        guard case .success(let result) = calculatorResult else {
            XCTFail("Calculation failed")
            return
        }
        
        XCTAssertTrue(result == "9.45", "with a quantity of 5 and coupon FIVE, the result should be equal to the price * 5 minus 5%")
    }
    
    func testSingleProductWithCouponTen() throws {
        let product = Product(id: UUID(), name: "Test Product 1", price: "1.99")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 1, coupon: .tenPercent)
        
        guard case .success(let result) = calculatorResult else {
            XCTFail("Calculation failed")
            return
        }
        
        XCTAssertTrue(result == "1.79", "with a quantity of 1 and coupon TEN, the result should be equal to single price minus 10%")
    }
    
    func testMultipleProductsWithCouponTen() throws {
        let product = Product(id: UUID(), name: "Test Product 1", price: "1.99")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 5, coupon: .tenPercent)
        
        guard case .success(let result) = calculatorResult else {
            XCTFail("Calculation failed")
            return
        }
        
        XCTAssertTrue(result == "8.96", "with a quantity of 5 and coupon TEN, the result should be equal to the price * 5 minus 10%")
    }
    
    func testProductDoubleConversionCanFail() throws {
        let product = Product(id: UUID(), name: "Failing Product 1", price: "ABC")
        let calculatorResult = ProductQuantityCalculator.calculate(product: product, quantity: 1, coupon: nil)
        
        guard case .failure(let error) = calculatorResult else {
            XCTFail("Calculation succeeded. This should not be the case")
            return
        }
        
        XCTAssertTrue(error == .internalError, "The String -> Double conversion should fail.")
    }
}
