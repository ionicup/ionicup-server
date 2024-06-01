import Foundation
import ArgumentParser
import Hummingbird
import Logging
import IonicupModels

@main
struct IonicupServer: AsyncParsableCommand {
    
    @Option(name: .shortAndLong)
    var hostname: String = ProcessInfo.processInfo.environment["HOSTNAME"] ?? "0.0.0.0"


    @Option(name: .shortAndLong)
    var port: Int = ProcessInfo.processInfo.environment["PORT"].flatMap { Int($0) } ?? 8080
    
    func run() async throws {
        let app = try await buildApplication(self)
        try await app.runService()
    }
}

func buildApplication(_ args: IonicupServer) async throws -> some ApplicationProtocol {
    var logger = Logger(label: "Ionicup")
    logger.logLevel = .debug
    
    let router = Router()
    
    router.middlewares.add(LogRequestsMiddleware(.info))
    
    router.get("/") { request, context in
        "Ionicup\n"
    }
    
    CRUDController(source: .inMemory(Match.self)).addRoutes(to: router.group("matches"))
    
    let app = Application(
        router: router,
        configuration: ApplicationConfiguration(address: .hostname(args.hostname, port: args.port)),
        logger: logger
    )
    
    return app
}
