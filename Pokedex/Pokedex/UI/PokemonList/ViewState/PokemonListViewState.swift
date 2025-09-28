import Foundation

enum PokemonListViewState {
    case loading
    case success([PokemonListItem])
    case error(Error)
    
    var pokemonList: [PokemonListItem]? {
        if case .success(let list) = self {
            return list
        }
        return nil
    }
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
}
