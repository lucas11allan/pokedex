import Foundation

// MARK: - Response Models for API Parsing
struct PokemonResponse: Codable {
    let id: Int
    let name: String
    let sprites: SpritesResponse?
    let types: [PokemonTypeResponse]?
    let stats: [PokemonStatResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, sprites, types, stats
    }
}

struct SpritesResponse: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonTypeResponse: Codable {
    let slot: Int
    let type: TypeInfoResponse
}

struct TypeInfoResponse: Codable {
    let name: String
    let url: String
}

struct PokemonStatResponse: Codable {
    let baseStat: Int
    let stat: StatInfoResponse
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfoResponse: Codable {
    let name: String
    let url: String
}

