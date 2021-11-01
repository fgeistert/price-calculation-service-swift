# price-calculation-service-swift

This is an example project for a university project. It uses Vapor to serve a microservice written in Swift. 

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
Part of this assignment was to fullfill at least eight of the twelve factors described in [The Twelve-Factor App](https://12factor.net/). 

### 1. Codebase ✅
One codebase tracked in revision control, many deploys

> The code and its history is tracked using git on GitHub. Deploys can be tracked using a branching model, e.g. development / staging / main to push to dev / staging / prod environments.

### 2. Dependencies ✅
Explicitly declare and isolate dependencies

> The app's dependencies are explicitly declared in the `Package.swift` file, where the Swift Package Manager handles the dependencies.

### 3. Config ✅
Store config in the environment

> Environment configurations for dev / staging / prod should not be put in code, but handled via configuration files that can be loaded into the environment. This can be handled with Vapor by using .env files injected into the environment. See [here](https://docs.vapor.codes/4.0/environment/) for reference. Per default a template `.env` file is part of the git repository. Environment files should not be committed into git, because they can contain secrets such as passwords.

### 4. Backing services ☑️
Treat backing services as attached resources

> Without changing code, backing services (e.g. databases, other APIs) can be exchanged. Since this example does not rely on other backing services, it is not implemented.

### 5. Build, release, run ✅
Strictly separate build and run stages

> build, release and run phases are separated. Therefore it is not possible to change code at runtime. For a real microservice, a CI/CD service could be used to allow for automatic build, release and run integration. 

### 6. Processes ✅
Execute the app as one or more stateless processes

> The app is run using a stateless, isolated docker container.

### 7. Port binding ✅
Export services via port binding

> The app is run by port binding the `8080` port to the docker container.

### 8. Concurrency ☑️
Scale out via the process model

> New with Swift 5.5 it enables concurrency via the new async/await API. Vapor [supports](https://docs.vapor.codes/4.0/async/#async-await) the new concurrency features.

### 9. Disposability ✅
Maximize robustness with fast startup and graceful shutdown

> Using docker, starting / stopping a container is as easy as a one line bash command.

### 10. Dev/prod parity ☑️
Keep development, staging, and production as similar as possible

> For this example project no multiple releases to different environments were made. However, since configuration is done via .env files, the docker image could easily be run on different environments. 

### 11. Logs ✅
Treat logs as event streams

> This behavior is built into [Vapor](https://docs.vapor.codes/4.0/logging/). Logs can be handled differently depending on the environment. 

### 12. Admin processes ☑️
Run admin/management tasks as one-off processes

> For this project, no one-time processes were needed just yet. However, if database migrations or other one-time scripts were needed, they would have to be considered.

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

to run the docker container, run:

```bash
docker run -dp 8080:8080 price-calculation-service-swift
```

now visit `localhost:8080/alive`.

to stop the docker container, run:

```bash
docker stop {CONTAINER ID}
```

## License

MIT
