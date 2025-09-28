import Foundation
import Alamofire

struct PokemonListRequest: NetworkRequest {
    var path: String { "/pokemon" }
    var method: HTTPMethod { .get }
    var parameters: Parameters?
    
    init(offset: Int, limit: Int) {
        self.parameters = ["offset": offset, "limit": limit]
    }
}
