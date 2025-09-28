import Foundation
import Alamofire

struct PokemonDetailRequest: NetworkRequest {
    var path: String
    var method: HTTPMethod { .get }
    
    init(id: Int) {
        self.path = "/pokemon/\(id)"
    }
}
