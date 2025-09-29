import XCTest
@testable import Pokedex

class PokemonServiceTests: XCTestCase {
    
    // MARK: - PokemonListService Tests
    
    func testPokemonListServiceFetchSuccess() async throws {
        // Given
        let mockNetworkService = MockNetworkService()
        let pokemonListService = PokemonListService(networkService: mockNetworkService)
        
        let expectedResponse = PokemonListResponse(
            count: 2,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            results: [
                PokemonListItemResponse(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                PokemonListItemResponse(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
            ]
        )
        mockNetworkService.mockResponse = expectedResponse
        
        // When
        let result = try await pokemonListService.fetchPokemonList(offset: 0, limit: 20)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.results.count, 2)
        XCTAssertEqual(result.results[0].name, "bulbasaur")
        XCTAssertEqual(result.results[1].name, "ivysaur")
        XCTAssertEqual(mockNetworkService.callCount, 1)
    }
    
    func testPokemonListServiceFetchError() async {
        // Given
        let mockNetworkService = MockNetworkService()
        mockNetworkService.shouldThrowError = true
        let pokemonListService = PokemonListService(networkService: mockNetworkService)
        
        // When & Then
        do {
            _ = try await pokemonListService.fetchPokemonList(offset: 0, limit: 20)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is PokemonTestError)
            XCTAssertEqual(mockNetworkService.callCount, 1)
        }
    }
    
    // MARK: - PokemonDetailService Tests
    
    func testPokemonDetailServiceFetchSuccess() async throws {
        // Given
        let mockNetworkService = MockNetworkService()
        let pokemonDetailService = PokemonDetailService(networkService: mockNetworkService)
        
        let expectedResponse = PokemonResponse(
            id: 1,
            name: "bulbasaur",
            sprites: SpritesResponse(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            types: [
                PokemonTypeResponse(
                    slot: 1,
                    type: TypeInfoResponse(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")
                )
            ],
            stats: [
                PokemonStatResponse(
                    baseStat: 45,
                    stat: StatInfoResponse(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
                )
            ]
        )
        mockNetworkService.mockResponse = expectedResponse
        
        // When
        let result = try await pokemonDetailService.fetchPokemon(id: 1)
        
        // Then
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "bulbasaur")
        XCTAssertNotNil(result.sprites?.frontDefault)
        XCTAssertEqual(result.types?.count, 1)
        XCTAssertEqual(result.types?.first?.type.name, "grass")
        XCTAssertEqual(mockNetworkService.callCount, 1)
    }
    
    func testPokemonDetailServiceFetchError() async {
        // Given
        let mockNetworkService = MockNetworkService()
        mockNetworkService.shouldThrowError = true
        let pokemonDetailService = PokemonDetailService(networkService: mockNetworkService)
        
        // When & Then
        do {
            _ = try await pokemonDetailService.fetchPokemon(id: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is PokemonTestError)
            XCTAssertEqual(mockNetworkService.callCount, 1)
        }
    }
    
    // MARK: - Data Transformation Tests
    
    func testPokemonListResponseToDomain() {
        // Given
        let response = PokemonListResponse(
            count: 2,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            results: [
                PokemonListItemResponse(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                PokemonListItemResponse(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
            ]
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.count, 2)
        XCTAssertEqual(domain.next, "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20")
        XCTAssertNil(domain.previous)
        XCTAssertEqual(domain.results.count, 2)
        XCTAssertEqual(domain.results[0].id, 1)
        XCTAssertEqual(domain.results[0].name, "Bulbasaur")
        XCTAssertEqual(domain.results[1].id, 2)
        XCTAssertEqual(domain.results[1].name, "Ivysaur")
    }
    
    func testPokemonListItemResponseToDomain() {
        // Given
        let response = PokemonListItemResponse(
            name: "bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/"
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.id, 1)
        XCTAssertEqual(domain.name, "Bulbasaur")
        XCTAssertEqual(domain.url, "https://pokeapi.co/api/v2/pokemon/1/")
        XCTAssertEqual(domain.imageUrl?.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
    
    func testPokemonResponseToDomain() {
        // Given
        let response = PokemonResponse(
            id: 1,
            name: "bulbasaur",
            sprites: SpritesResponse(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            types: [
                PokemonTypeResponse(
                    slot: 1,
                    type: TypeInfoResponse(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")
                )
            ],
            stats: [
                PokemonStatResponse(
                    baseStat: 45,
                    stat: StatInfoResponse(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
                )
            ]
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.id, 1)
        XCTAssertEqual(domain.name, "Bulbasaur")
        XCTAssertEqual(domain.imageUrl?.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        XCTAssertEqual(domain.types?.count, 1)
        XCTAssertEqual(domain.types?.first?.type.name, "Grass")
        XCTAssertEqual(domain.stats?.count, 1)
        XCTAssertEqual(domain.stats?.first?.stat.name, "Hp")
    }
}
