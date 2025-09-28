import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T {
        let url = request.baseURL + request.path
        let method = request.method.rawValue
        
        print("🌐 [NETWORK] Making \(method) request to: \(url)")
        if let parameters = request.parameters {
            print("📦 [NETWORK] Parameters: \(parameters)")
        }
        if let headers = request.headers {
            print("📋 [NETWORK] Headers: \(headers)")
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: request.method,
                parameters: request.parameters,
                encoding: request.encoding,
                headers: request.headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                print("📡 [NETWORK] Response Status: \(response.response?.statusCode ?? -1)")
                print("⏱️ [NETWORK] Response Time: \(response.metrics?.taskInterval.duration ?? 0)s")
                
                switch response.result {
                case .success(let value):
                    print("✅ [NETWORK] Request successful")
                    continuation.resume(returning: value)
                case .failure(let error):
                    print("❌ [NETWORK] Request failed: \(error.localizedDescription)")
                    if let data = response.data {
                        let responseString = String(data: data, encoding: .utf8) ?? "Unable to convert to string"
                        print("📄 [NETWORK] Response Data: \(responseString)")
                    }
                    if let statusCode = response.response?.statusCode {
                        print("🔢 [NETWORK] Status Code: \(statusCode)")
                    }
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
