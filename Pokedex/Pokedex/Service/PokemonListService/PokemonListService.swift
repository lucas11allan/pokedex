import Foundation

protocol PokemonListServiceProtocol {
    func fetchPokemonList(offset: Int, limit: Int) async throws -> PokemonListResponse
}

class PokemonListService: PokemonListServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(offset: Int, limit: Int) async throws -> PokemonListResponse {
        let request = PokemonListRequest(offset: offset, limit: limit)
        let response: PokemonListResponse = try await networkService.request(request)
        return response
    }
}
