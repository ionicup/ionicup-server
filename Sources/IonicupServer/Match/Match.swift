import Foundation
import Hummingbird
import IonicupModels

struct Match: ResponseCodable, CRUDModel {
    var id = UUID()
    var homeTeam: String?
    var awayTeam: String?
}
