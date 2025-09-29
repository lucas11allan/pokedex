import Foundation
import Combine

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var viewState: PokemonDetailViewState = .loading
    
    private let pokemonDetailService: PokemonDetailServiceProtocol
    private let pokemonId: Int
    
    init(pokemonId: Int, pokemonDetailService: PokemonDetailServiceProtocol) {
        self.pokemonId = pokemonId
        self.pokemonDetailService = pokemonDetailService
    }
    
    func loadPokemon() {
        viewState = .loading
        
        Task {
            do {
                let pokemon = try await pokemonDetailService.fetchPokemon(id: pokemonId)
                viewState = .success(pokemon.toDomain())
            } catch {
                viewState = .error(error)
            }
        }
    }
}
