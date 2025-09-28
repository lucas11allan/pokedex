import Foundation

// MARK: - Response Models for API Parsing
struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItemResponse]
}

struct PokemonListItemResponse: Codable {
    let name: String
    let url: String
}


