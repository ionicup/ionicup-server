import Foundation

actor InMemoiryCRUDSource<Model: CRUDModel>: CRUDSource {
    
    var models: [Model] = []
    
    func create(model: Model) async throws {
        guard !models.map(\.id).contains(model.id) else {
            throw CRUDError.modelAlreadyPresent
        }
        
        models.append(model)
    }
    
    func read(id: Model.ID) async throws -> Model? {
        models.first { $0.id == id }
    }
    
    func readAll(bounds: Range<[Model].Index>?) async throws -> [Model] {
        if let bounds {
            Array(models[bounds])
        } else {
            models
        }
    }
    
    func update(model: Model) async throws {
        guard let index = models.firstIndex(where: { $0.id == model.id }) else {
            throw CRUDError.modelNotPresent
        }
        
        models[index] = model
    }
    
    func delete(id: Model.ID) async throws {
        guard let index = models.firstIndex(where: { $0.id == id }) else {
            throw CRUDError.modelNotPresent
        }
        
        models.remove(at: index)
    }
    
    func deleteAll() async throws {
        models.removeAll()
    }
}

extension CRUDSource {
    
    static func inMemory<M>(_ modelType: M.Type = M.self) -> InMemoiryCRUDSource<M> where Self == InMemoiryCRUDSource<M> {
        InMemoiryCRUDSource()
    }
}
