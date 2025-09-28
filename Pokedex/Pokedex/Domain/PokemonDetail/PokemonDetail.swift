import Foundation

// MARK: - PokemonDetail Domain Models
struct PokemonDetail: Identifiable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let types: [PokemonType]?
    let stats: [PokemonStat]?
    
    init(id: Int, name: String, imageUrl: URL?, types: [PokemonType]?, stats: [PokemonStat]?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.types = types
        self.stats = stats
    }
}

struct PokemonType {
    let slot: Int
    let type: TypeInfo
    
    init(slot: Int, type: TypeInfo) {
        self.slot = slot
        self.type = type
    }
}

struct TypeInfo {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct PokemonStat {
    let baseStat: Int
    let stat: StatInfo
    
    init(baseStat: Int, stat: StatInfo) {
        self.baseStat = baseStat
        self.stat = stat
    }
}

struct StatInfo {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
