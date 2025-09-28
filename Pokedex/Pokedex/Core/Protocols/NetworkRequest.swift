import Foundation
import Alamofire

protocol NetworkRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension NetworkRequest {
    var baseURL: String { "https://pokeapi.co/api/v2" }
    var headers: HTTPHeaders? { nil }
    var parameters: Parameters? { nil }
    var encoding: ParameterEncoding { URLEncoding.default }
}
