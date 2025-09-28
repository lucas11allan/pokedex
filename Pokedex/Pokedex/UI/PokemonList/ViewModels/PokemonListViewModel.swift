import Foundation
import Combine

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var viewState: PokemonListViewState = .loading
    @Published var pokemonList: [PokemonListItem] = []
    
    private let pokemonListService: PokemonListServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentOffset = 0
    private let limit = 20
    
    init(pokemonListService: PokemonListServiceProtocol) {
        self.pokemonListService = pokemonListService
    }
    
    func loadPokemonList() {
        print("🔄 [POKEMON_LIST] Loading pokemon list...")
        viewState = .loading
        
        Task {
            do {
                let response = try await pokemonListService.fetchPokemonList(offset: currentOffset, limit: limit)
                pokemonList = response.results.map { $0.toDomain() }
                print("✅ [POKEMON_LIST] Successfully loaded \(pokemonList.count) pokemon")
                viewState = .success(pokemonList)
            } catch {
                print("❌ [POKEMON_LIST] Error loading pokemon list: \(error.localizedDescription)")
                viewState = .error(error)
            }
        }
    }
    
    func loadMorePokemon() {
        print("🔄 [POKEMON_LIST] Loading more pokemon...")
        currentOffset += limit
        
        Task {
            do {
                let response = try await pokemonListService.fetchPokemonList(offset: currentOffset, limit: limit)
                pokemonList.append(contentsOf: response.results.map { $0.toDomain() })
                print("✅ [POKEMON_LIST] Successfully loaded \(response.results.count) more pokemon. Total: \(pokemonList.count)")
                viewState = .success(pokemonList)
            } catch {
                print("❌ [POKEMON_LIST] Error loading more pokemon: \(error.localizedDescription)")
                viewState = .error(error)
            }
        }
    }
    
    func refreshPokemonList() {
        print("🔄 [POKEMON_LIST] Refreshing pokemon list...")
        currentOffset = 0
        pokemonList.removeAll()
        loadPokemonList()
    }
}
