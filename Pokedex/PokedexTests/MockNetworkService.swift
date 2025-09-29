//
//  MockNetworkService.swift
//  PokedexTests
//
//  Created by Lucas Allan Almeida Oliveira on 29/09/25.
//

import Foundation
@testable import Pokedex

// MARK: - Mock Network Service
class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: Any?
    var shouldThrowError = false
    var callCount = 0
    
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T {
        callCount += 1
        
        if shouldThrowError {
            throw PokemonTestError.networkError
        }
        
        guard let response = mockResponse as? T else {
            throw PokemonTestError.noData
        }
        
        return response
    }
}
