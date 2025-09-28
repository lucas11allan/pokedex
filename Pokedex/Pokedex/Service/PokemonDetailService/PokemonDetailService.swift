import Foundation

protocol PokemonDetailServiceProtocol {
    func fetchPokemon(id: Int) async throws -> PokemonDetail
}

class PokemonDetailService: PokemonDetailServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPokemon(id: Int) async throws -> PokemonDetail {
        let request = PokemonDetailRequest(id: id)
        let response: PokemonResponse = try await networkService.request(request)
        return response.toDomain()
    }
}
