# price-calculation-service-swift

This is an example project for university project. It uses Vapor to serve a microservice written in Swift. 

The point of this assignment is to serve a microservice with Docker.

Unit Tests + Integration Tests are included in the `Tests` Folder.

## How to use this API
This API offers three endpoints.

### `/alive` endpoint

returns "Alive" to verify the service is running.

### `/price` endpoint

returns the calculation of the requested product.

Valid URL parameters:

- `productId` required - the UUID of the requested product (see `/Sources/App/Resources/products.json` for reference)
- `quantity` required - the requested quantity of this product. Int
- `coupon` optional - either `FIVE` or `TEN` to get 5% or 10% discount

### `/products` endpoint

returns a list of all available products.

## The 12-Factor App
Part of this assignment was to fullfill the factors described in [The Twelve-Factor App](https://12factor.net/).

TODO

## Build Docker Image
For reference see [Vapor Documention](https://docs.vapor.codes/4.0/deploy/docker/).

to build the docker image, simply run: (this might take a while)

```bash
docker-compose build
```

to list all built docker images on your maschine, run:

```bash
docker image ls
```

to run a docker image, run:

```bash
docker run -dp 8080:8080 price-calculation-service-swift
```

now visit `localhost:8080/alive`.

## License

MIT
