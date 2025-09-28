import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites?
    let types: [PokemonType]?
    let stats: [PokemonStat]?
    
    var imageUrl: URL? {
        guard let sprites = sprites, let frontDefault = sprites.frontDefault else { return nil }
        return URL(string: frontDefault)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, sprites, types, stats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decodeIfPresent(Sprites.self, forKey: .sprites)
        types = try container.decodeIfPresent([PokemonType].self, forKey: .types)
        stats = try container.decodeIfPresent([PokemonStat].self, forKey: .stats)
    }
    
    // For preview purposes
    init(id: Int, name: String, sprites: Sprites?, types: [PokemonType]?, stats: [PokemonStat]?) {
        self.id = id
        self.name = name
        self.sprites = sprites
        self.types = types
        self.stats = stats
    }
}

struct Sprites: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Codable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
    let url: String
}

struct PokemonStat: Codable {
    let baseStat: Int
    let stat: StatInfo
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfo: Codable {
    let name: String
    let url: String
}
