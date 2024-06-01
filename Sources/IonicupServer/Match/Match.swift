import Foundation
import Hummingbird

struct Match: ResponseCodable, CRUDModel {
    var id = UUID()
    var homeTeam: String?
    var awayTeam: String?
}
