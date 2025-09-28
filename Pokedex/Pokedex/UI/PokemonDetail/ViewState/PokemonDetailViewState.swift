import Foundation

enum PokemonDetailViewState {
    case loading
    case success(Pokemon)
    case error(Error)
    
    var pokemon: Pokemon? {
        if case .success(let pokemon) = self {
            return pokemon
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
