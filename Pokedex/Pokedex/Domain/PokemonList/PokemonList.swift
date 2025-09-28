import Foundation

// MARK: - PokemonList Domain Models
struct PokemonList: Identifiable {
    let id = UUID()
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
    
    init(count: Int, next: String?, previous: String?, results: [PokemonListItem]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

struct PokemonListItem: Identifiable {
    let id: Int
    let name: String
    let url: String
    let imageUrl: URL?
    
    init(id: Int, name: String, url: String, imageUrl: URL?) {
        self.id = id
        self.name = name
        self.url = url
        self.imageUrl = imageUrl
    }
}
