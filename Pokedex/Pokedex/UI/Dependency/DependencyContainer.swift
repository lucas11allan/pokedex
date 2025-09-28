import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    private let networkService: NetworkServiceProtocol
    
    private init() {
        self.networkService = NetworkService()
    }
    
    func makePokemonListService() -> PokemonListServiceProtocol {
        return PokemonListService(networkService: networkService)
    }
    
    func makePokemonDetailService() -> PokemonDetailServiceProtocol {
        return PokemonDetailService(networkService: networkService)
    }
    
    @MainActor func makePokemonListViewModel() -> PokemonListViewModel {
        return PokemonListViewModel(pokemonListService: makePokemonListService())
    }
    
    @MainActor func makePokemonDetailViewModel(pokemonId: Int) -> PokemonDetailViewModel {
        return PokemonDetailViewModel(pokemonId: pokemonId, pokemonDetailService: makePokemonDetailService())
    }
}
