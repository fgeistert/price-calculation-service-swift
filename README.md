# price-calculation-service-swift

This is an example project for university project. It uses Vapor to serve a microservice written in Swift. 

The point of this assignment is to serve a microservice with Docker.

Unit Tests + Integration Tests are included in the `Tests` Folder.

## How to use this API
This API offers two endpoints.

### `/alive` endpoint

returns "Alive" to verify the service is running.

### `/price` endpoint

returns the calculation of the requested product.

Valid URL parameters:

- `productId` required - the UUID of the requested product (see `/Sources/App/Resources/products.json` for reference)
- `quantity` required - the requested quantity of this product. Int
- `coupon` optional - either `FIVE` or `TEN` to get 5% or 10% discount

## License

MIT