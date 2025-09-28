import Foundation

protocol PokemonDetailServiceProtocol {
    func fetchPokemon(id: Int) async throws -> Pokemon
}

class PokemonDetailService: PokemonDetailServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPokemon(id: Int) async throws -> Pokemon {
        let request = PokemonDetailRequest(id: id)
        return try await networkService.request(request)
    }
}
