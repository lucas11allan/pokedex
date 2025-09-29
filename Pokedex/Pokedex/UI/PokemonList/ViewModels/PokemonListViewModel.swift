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
        viewState = .loading
        
        Task {
            do {
                let response = try await pokemonListService.fetchPokemonList(offset: currentOffset, limit: limit)
                pokemonList = response.results.map { $0.toDomain() }
                viewState = .success(pokemonList)
            } catch {
                viewState = .error(error)
            }
        }
    }
    
    func loadMorePokemon() {
        currentOffset += limit
        
        Task {
            do {
                let response = try await pokemonListService.fetchPokemonList(offset: currentOffset, limit: limit)
                pokemonList.append(contentsOf: response.results.map { $0.toDomain() })
                viewState = .success(pokemonList)
            } catch {
                viewState = .error(error)
            }
        }
    }
    
    func refreshPokemonList() {
        currentOffset = 0
        pokemonList.removeAll()
        loadPokemonList()
    }
}
