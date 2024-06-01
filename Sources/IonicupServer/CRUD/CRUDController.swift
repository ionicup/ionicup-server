import Foundation
import Hummingbird

struct CRUDController<Source: CRUDSource> where Source.Model: ResponseCodable, Source.Model.ID == UUID {
    
    let source: Source
    
    func addRoutes(to group: RouterGroup<some RequestContext>) {
        group
            .post(use: create)
            .get(":id", use: read)
    }
    
    @Sendable func create(request: Request, context: some RequestContext) async throws -> HTTPResponse.Status {
        let model = try await request.decode(as: Source.Model.self, context: context)
        try await source.create(model: model)
        return .created
    }
    
    @Sendable func read(request: Request, context: some RequestContext) async throws -> Source.Model? {
        let id = try context.parameters.require("id", as: Source.Model.ID.self)
        return try await source.read(id: id)
    }
}
