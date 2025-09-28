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
        print("🔄 [POKEMON_DETAIL] Loading pokemon with ID: \(pokemonId)")
        viewState = .loading
        
        Task {
            do {
                let pokemon = try await pokemonDetailService.fetchPokemon(id: pokemonId)
                print("✅ [POKEMON_DETAIL] Successfully loaded pokemon: \(pokemon.name)")
                viewState = .success(pokemon)
            } catch {
                print("❌ [POKEMON_DETAIL] Error loading pokemon: \(error.localizedDescription)")
                viewState = .error(error)
            }
        }
    }
}
