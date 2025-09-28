import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    let url: String
    
    var id: Int {
        let urlParts = url.split(separator: "/")
        return Int(urlParts.last ?? "0") ?? 0
    }
    
    var imageUrl: URL? {
        let idString = String(id)
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idString).png")
    }
}
