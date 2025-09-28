import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T
}
