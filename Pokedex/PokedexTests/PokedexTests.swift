//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Lucas Allan Almeida Oliveira on 28/09/25.
//

import XCTest
@testable import Pokedex

final class PokedexTests: XCTestCase {
    
    // MARK: - PokemonListViewModel Tests
    
    @MainActor
    func testPokemonListViewModelInitialState() {
        // Given
        let mockService = MockPokemonListService()
        let viewModel = PokemonListViewModel(pokemonListService: mockService)
        
        // Then
        XCTAssertTrue(viewModel.viewState.isLoading)
        XCTAssertEqual(viewModel.pokemonList.count, 0)
    }
    
    @MainActor
    func testPokemonListViewModelLoadPokemonListSuccess() async {
        // Given
        let mockService = MockPokemonListService()
        let expectedPokemon = PokemonListItem(
            id: 1,
            name: "Bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        )
        mockService.mockPokemonList = PokemonList(
            count: 1,
            next: nil,
            previous: nil,
            results: [expectedPokemon]
        )
        let viewModel = PokemonListViewModel(pokemonListService: mockService)
        
        // When
        viewModel.loadPokemonList()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Then
        XCTAssertFalse(viewModel.viewState.isLoading)
        XCTAssertEqual(viewModel.pokemonList.count, 1)
        XCTAssertEqual(viewModel.pokemonList.first?.name, "Bulbasaur")
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    @MainActor
    func testPokemonListViewModelLoadPokemonListError() async {
        // Given
        let mockService = MockPokemonListService()
        mockService.shouldThrowError = true
        let viewModel = PokemonListViewModel(pokemonListService: mockService)
        
        // When
        viewModel.loadPokemonList()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Then
        XCTAssertFalse(viewModel.viewState.isLoading)
        XCTAssertNotNil(viewModel.viewState.error)
        XCTAssertEqual(viewModel.pokemonList.count, 0)
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    @MainActor
    func testPokemonListViewModelLoadMorePokemon() async {
        // Given
        let mockService = MockPokemonListService()
        let initialPokemon = PokemonListItem(
            id: 1,
            name: "Bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        )
        let additionalPokemon = PokemonListItem(
            id: 2,
            name: "Ivysaur",
            url: "https://pokeapi.co/api/v2/pokemon/2/",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")
        )
        
        mockService.mockPokemonList = PokemonList(
            count: 2,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            results: [additionalPokemon]
        )
        
        let viewModel = PokemonListViewModel(pokemonListService: mockService)
        viewModel.pokemonList = [initialPokemon]
        
        // When
        viewModel.loadMorePokemon()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Then
        XCTAssertEqual(viewModel.pokemonList.count, 2)
        XCTAssertEqual(viewModel.pokemonList[0].name, "Bulbasaur")
        XCTAssertEqual(viewModel.pokemonList[1].name, "Ivysaur")
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    // MARK: - PokemonDetailViewModel Tests
    
    @MainActor
    func testPokemonDetailViewModelInitialState() {
        // Given
        let mockService = MockPokemonDetailService()
        let viewModel = PokemonDetailViewModel(pokemonId: 1, pokemonDetailService: mockService)
        
        // Then
        XCTAssertTrue(viewModel.viewState.isLoading)
    }
    
    @MainActor
    func testPokemonDetailViewModelLoadPokemonSuccess() async {
        // Given
        let mockService = MockPokemonDetailService()
        let expectedPokemon = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            types: [PokemonType(slot: 1, type: TypeInfo(name: "Grass", url: "https://pokeapi.co/api/v2/type/12/"))],
            stats: [PokemonStat(baseStat: 45, stat: StatInfo(name: "HP", url: "https://pokeapi.co/api/v2/stat/1/"))]
        )
        mockService.mockPokemon = expectedPokemon
        let viewModel = PokemonDetailViewModel(pokemonId: 1, pokemonDetailService: mockService)
        
        // When
        viewModel.loadPokemon()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Then
        XCTAssertFalse(viewModel.viewState.isLoading)
        XCTAssertNotNil(viewModel.viewState.pokemon)
        XCTAssertEqual(viewModel.viewState.pokemon?.name, "Bulbasaur")
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    @MainActor
    func testPokemonDetailViewModelLoadPokemonError() async {
        // Given
        let mockService = MockPokemonDetailService()
        mockService.shouldThrowError = true
        let viewModel = PokemonDetailViewModel(pokemonId: 1, pokemonDetailService: mockService)
        
        // When
        viewModel.loadPokemon()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        // Then
        XCTAssertFalse(viewModel.viewState.isLoading)
        XCTAssertNotNil(viewModel.viewState.error)
        XCTAssertNil(viewModel.viewState.pokemon)
        XCTAssertEqual(mockService.callCount, 1)
    }
}

// MARK: - Mock Services for Testing
class MockPokemonListService: PokemonListServiceProtocol {
    var mockPokemonList: PokemonList?
    var shouldThrowError = false
    var callCount = 0
    
    func fetchPokemonList(offset: Int, limit: Int) async throws -> PokemonListResponse {
        callCount += 1
        
        if shouldThrowError {
            throw PokemonTestError.networkError
        }
        
        guard let pokemonList = mockPokemonList else {
            throw PokemonTestError.noData
        }
        
        // Convert domain model back to response model for testing
        return PokemonListResponse(
            count: pokemonList.count,
            next: pokemonList.next,
            previous: pokemonList.previous,
            results: pokemonList.results.map { pokemon in
                PokemonListItemResponse(
                    name: pokemon.name.lowercased(),
                    url: pokemon.url
                )
            }
        )
    }
}

class MockPokemonDetailService: PokemonDetailServiceProtocol {
    var mockPokemon: PokemonDetail?
    var shouldThrowError = false
    var callCount = 0
    
    func fetchPokemon(id: Int) async throws -> PokemonResponse {
        callCount += 1
        
        if shouldThrowError {
            throw PokemonTestError.networkError
        }
        
        guard let pokemon = mockPokemon else {
            throw PokemonTestError.noData
        }
        
        // Convert domain model back to response model for testing
        return PokemonResponse(
            id: pokemon.id,
            name: pokemon.name.lowercased(),
            sprites: SpritesResponse(
                frontDefault: pokemon.imageUrl?.absoluteString
            ),
            types: pokemon.types?.map { type in
                PokemonTypeResponse(
                    slot: type.slot,
                    type: TypeInfoResponse(
                        name: type.type.name.lowercased(),
                        url: type.type.url
                    )
                )
            },
            stats: pokemon.stats?.map { stat in
                PokemonStatResponse(
                    baseStat: stat.baseStat,
                    stat: StatInfoResponse(
                        name: stat.stat.name.lowercased(),
                        url: stat.stat.url
                    )
                )
            }
        )
    }
}

// MARK: - Test Error
enum PokemonTestError: Error {
    case networkError
    case noData
}
