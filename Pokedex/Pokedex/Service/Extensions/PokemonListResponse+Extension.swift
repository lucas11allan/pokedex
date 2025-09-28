import Foundation

// MARK: - Extensions to convert Response to Domain
extension PokemonListResponse {
    func toDomain() -> PokemonList {
        return PokemonList(
            count: count,
            next: next,
            previous: previous,
            results: results.map { $0.toDomain() }
        )
    }
}

extension PokemonListItemResponse {
    func toDomain() -> PokemonListItem {
        let pokemonId = extractIdFromUrl(url)
        let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")
        
        return PokemonListItem(
            id: pokemonId,
            name: name.capitalized,
            url: url,
            imageUrl: imageUrl
        )
    }
    
    private func extractIdFromUrl(_ url: String) -> Int {
        let urlParts = url.split(separator: "/")
        return Int(urlParts.last ?? "0") ?? 0
    }
}
