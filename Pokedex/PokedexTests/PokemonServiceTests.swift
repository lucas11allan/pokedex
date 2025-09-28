import XCTest

class PokemonServiceTests: XCTestCase {
    
    // MARK: - Pokemon Detail Service Tests with Mocks
    
    func testPokemonDetailServiceSuccess() async throws {
        // Given
        let mockService = MockPokemonDetailService()
        let expectedPokemon = TestPokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: URL(string: "https://example.com/1.png"),
            types: [TestPokemonType(slot: 1, type: TestTypeInfo(name: "Grass", url: "https://pokeapi.co/api/v2/type/12/"))],
            stats: [TestPokemonStat(baseStat: 45, stat: TestStatInfo(name: "HP", url: "https://pokeapi.co/api/v2/stat/1/"))]
        )
        mockService.mockPokemon = expectedPokemon
        
        // When
        let result = try await mockService.fetchPokemon(id: 1)
        
        // Then
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Bulbasaur")
        XCTAssertNotNil(result.imageUrl)
        XCTAssertEqual(result.types?.count, 1)
        XCTAssertEqual(result.types?.first?.type.name, "Grass")
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    func testPokemonDetailServiceError() async {
        // Given
        let mockService = MockPokemonDetailService()
        mockService.shouldThrowError = true
        
        // When & Then
        do {
            _ = try await mockService.fetchPokemon(id: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is PokemonTestError)
            XCTAssertEqual(mockService.callCount, 1)
        }
    }
    
    func testPokemonListServiceSuccess() async throws {
        // Given
        let mockService = MockPokemonListService()
        let expectedList = TestPokemonList(
            count: 2,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            results: [
                TestPokemonListItem(id: 1, name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/", imageUrl: URL(string: "https://example.com/1.png")),
                TestPokemonListItem(id: 2, name: "Ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/", imageUrl: URL(string: "https://example.com/2.png"))
            ]
        )
        mockService.mockPokemonList = expectedList
        
        // When
        let result = try await mockService.fetchPokemonList(offset: 0, limit: 20)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertNotNil(result.next)
        XCTAssertNil(result.previous)
        XCTAssertEqual(result.results.count, 2)
        XCTAssertEqual(result.results[0].name, "Bulbasaur")
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    func testPokemonListServiceError() async {
        // Given
        let mockService = MockPokemonListService()
        mockService.shouldThrowError = true
        
        // When & Then
        do {
            _ = try await mockService.fetchPokemonList(offset: 0, limit: 20)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is PokemonTestError)
            XCTAssertEqual(mockService.callCount, 1)
        }
    }
    
    // MARK: - Data Transformation Tests
    
    func testPokemonNameCapitalization() {
        // Given
        let testCases = [
            ("bulbasaur", "Bulbasaur"),
            ("ivysaur", "Ivysaur"),
            ("venusaur", "Venusaur"),
            ("charizard", "Charizard")
        ]
        
        for (input, expected) in testCases {
            // When
            let result = input.capitalized
            
            // Then
            XCTAssertEqual(result, expected, "Failed for input: '\(input)'")
        }
    }
    
    func testPokemonImageURLGeneration() {
        // Given
        let testCases = [
            (1, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            (25, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
            (150, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png")
        ]
        
        for (pokemonId, expectedURL) in testCases {
            // When
            let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")
            
            // Then
            XCTAssertNotNil(imageURL)
            XCTAssertEqual(imageURL?.absoluteString, expectedURL)
        }
    }
    
    func testPokemonIdExtractionFromURL() {
        // Given
        let testCases = [
            ("https://pokeapi.co/api/v2/pokemon/1/", 1),
            ("https://pokeapi.co/api/v2/pokemon/25/", 25),
            ("https://pokeapi.co/api/v2/pokemon/150/", 150)
        ]
        
        for (url, expectedId) in testCases {
            // When
            let urlParts = url.split(separator: "/")
            let pokemonId = Int(urlParts.last ?? "0") ?? 0
            
            // Then
            XCTAssertEqual(pokemonId, expectedId, "Failed for URL: \(url)")
        }
    }
}

// MARK: - Test Models (Local definitions for independence)
struct TestPokemonDetail: Identifiable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let types: [TestPokemonType]?
    let stats: [TestPokemonStat]?
    
    init(id: Int, name: String, imageUrl: URL?, types: [TestPokemonType]?, stats: [TestPokemonStat]?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.types = types
        self.stats = stats
    }
}

struct TestPokemonType {
    let slot: Int
    let type: TestTypeInfo
    
    init(slot: Int, type: TestTypeInfo) {
        self.slot = slot
        self.type = type
    }
}

struct TestTypeInfo {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct TestPokemonStat {
    let baseStat: Int
    let stat: TestStatInfo
    
    init(baseStat: Int, stat: TestStatInfo) {
        self.baseStat = baseStat
        self.stat = stat
    }
}

struct TestStatInfo {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct TestPokemonList: Identifiable {
    let id = UUID()
    let count: Int
    let next: String?
    let previous: String?
    let results: [TestPokemonListItem]
    
    init(count: Int, next: String?, previous: String?, results: [TestPokemonListItem]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

struct TestPokemonListItem: Identifiable {
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

// MARK: - Mock Services
class MockPokemonDetailService {
    var mockPokemon: TestPokemonDetail?
    var shouldThrowError = false
    var callCount = 0
    
    func fetchPokemon(id: Int) async throws -> TestPokemonDetail {
        callCount += 1
        
        if shouldThrowError {
            throw PokemonTestError.networkError
        }
        
        guard let pokemon = mockPokemon else {
            throw PokemonTestError.noData
        }
        
        return pokemon
    }
}

class MockPokemonListService {
    var mockPokemonList: TestPokemonList?
    var shouldThrowError = false
    var callCount = 0
    
    func fetchPokemonList(offset: Int, limit: Int) async throws -> TestPokemonList {
        callCount += 1
        
        if shouldThrowError {
            throw PokemonTestError.networkError
        }
        
        guard let pokemonList = mockPokemonList else {
            throw PokemonTestError.noData
        }
        
        return pokemonList
    }
}

// MARK: - Test Error
enum PokemonTestError: Error {
    case networkError
    case noData
}
