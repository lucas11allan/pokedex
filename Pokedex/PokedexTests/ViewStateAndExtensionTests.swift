//
//  ViewStateAndExtensionTests.swift
//  PokedexTests
//
//  Created by Lucas Allan Almeida Oliveira on 28/09/25.
//

import XCTest
@testable import Pokedex

class ViewStateAndExtensionTests: XCTestCase {
    
    // MARK: - PokemonListViewState Tests
    
    func testPokemonListViewStateLoading() {
        // Given
        let state = PokemonListViewState.loading
        
        // Then
        XCTAssertTrue(state.isLoading)
        XCTAssertNil(state.pokemonList)
        XCTAssertNil(state.error)
    }
    
    func testPokemonListViewStateSuccess() {
        // Given
        let pokemonList = [
            PokemonListItem(
                id: 1,
                name: "Bulbasaur",
                url: "https://pokeapi.co/api/v2/pokemon/1/",
                imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
            )
        ]
        let state = PokemonListViewState.success(pokemonList)
        
        // Then
        XCTAssertFalse(state.isLoading)
        XCTAssertNotNil(state.pokemonList)
        XCTAssertEqual(state.pokemonList?.count, 1)
        XCTAssertEqual(state.pokemonList?.first?.name, "Bulbasaur")
        XCTAssertNil(state.error)
    }
    
    func testPokemonListViewStateError() {
        // Given
        let testError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let state = PokemonListViewState.error(testError)
        
        // Then
        XCTAssertFalse(state.isLoading)
        XCTAssertNil(state.pokemonList)
        XCTAssertNotNil(state.error)
        XCTAssertEqual(state.error?.localizedDescription, "Test error")
    }
    
    // MARK: - PokemonDetailViewState Tests
    
    func testPokemonDetailViewStateLoading() {
        // Given
        let state = PokemonDetailViewState.loading
        
        // Then
        XCTAssertTrue(state.isLoading)
        XCTAssertNil(state.pokemon)
        XCTAssertNil(state.error)
    }
    
    func testPokemonDetailViewStateSuccess() {
        // Given
        let pokemon = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            types: [
                PokemonType(
                    slot: 1,
                    type: TypeInfo(name: "Grass", url: "https://pokeapi.co/api/v2/type/12/")
                )
            ],
            stats: [
                PokemonStat(
                    baseStat: 45,
                    stat: StatInfo(name: "HP", url: "https://pokeapi.co/api/v2/stat/1/")
                )
            ]
        )
        let state = PokemonDetailViewState.success(pokemon)
        
        // Then
        XCTAssertFalse(state.isLoading)
        XCTAssertNotNil(state.pokemon)
        XCTAssertEqual(state.pokemon?.name, "Bulbasaur")
        XCTAssertEqual(state.pokemon?.types?.count, 1)
        XCTAssertEqual(state.pokemon?.stats?.count, 1)
        XCTAssertNil(state.error)
    }
    
    func testPokemonDetailViewStateError() {
        // Given
        let testError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let state = PokemonDetailViewState.error(testError)
        
        // Then
        XCTAssertFalse(state.isLoading)
        XCTAssertNil(state.pokemon)
        XCTAssertNotNil(state.error)
        XCTAssertEqual(state.error?.localizedDescription, "Test error")
    }
    
    // MARK: - PokemonListResponse Extension Tests
    
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
    
    // MARK: - PokemonResponse Extension Tests
    
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
    
    func testPokemonTypeResponseToDomain() {
        // Given
        let response = PokemonTypeResponse(
            slot: 1,
            type: TypeInfoResponse(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.slot, 1)
        XCTAssertEqual(domain.type.name, "Grass")
        XCTAssertEqual(domain.type.url, "https://pokeapi.co/api/v2/type/12/")
    }
    
    func testTypeInfoResponseToDomain() {
        // Given
        let response = TypeInfoResponse(
            name: "grass",
            url: "https://pokeapi.co/api/v2/type/12/"
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.name, "Grass")
        XCTAssertEqual(domain.url, "https://pokeapi.co/api/v2/type/12/")
    }
    
    func testPokemonStatResponseToDomain() {
        // Given
        let response = PokemonStatResponse(
            baseStat: 45,
            stat: StatInfoResponse(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.baseStat, 45)
        XCTAssertEqual(domain.stat.name, "Hp")
        XCTAssertEqual(domain.stat.url, "https://pokeapi.co/api/v2/stat/1/")
    }
    
    func testStatInfoResponseToDomain() {
        // Given
        let response = StatInfoResponse(
            name: "hp",
            url: "https://pokeapi.co/api/v2/stat/1/"
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.name, "Hp")
        XCTAssertEqual(domain.url, "https://pokeapi.co/api/v2/stat/1/")
    }
    
    // MARK: - Edge Cases Tests
    
    func testPokemonListItemResponseWithInvalidURL() {
        // Given
        let response = PokemonListItemResponse(
            name: "bulbasaur",
            url: "invalid-url"
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.id, 0) // Should default to 0 for invalid URL
        XCTAssertEqual(domain.name, "Bulbasaur")
        XCTAssertEqual(domain.url, "invalid-url")
        XCTAssertEqual(domain.imageUrl?.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png")
    }
    
    func testPokemonResponseWithNilSprites() {
        // Given
        let response = PokemonResponse(
            id: 1,
            name: "bulbasaur",
            sprites: nil,
            types: nil,
            stats: nil
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.id, 1)
        XCTAssertEqual(domain.name, "Bulbasaur")
        XCTAssertNil(domain.imageUrl)
        XCTAssertNil(domain.types)
        XCTAssertNil(domain.stats)
    }
    
    func testPokemonResponseWithEmptyTypesAndStats() {
        // Given
        let response = PokemonResponse(
            id: 1,
            name: "bulbasaur",
            sprites: SpritesResponse(frontDefault: "https://example.com/1.png"),
            types: [],
            stats: []
        )
        
        // When
        let domain = response.toDomain()
        
        // Then
        XCTAssertEqual(domain.id, 1)
        XCTAssertEqual(domain.name, "Bulbasaur")
        XCTAssertEqual(domain.imageUrl?.absoluteString, "https://example.com/1.png")
        XCTAssertEqual(domain.types?.count, 0)
        XCTAssertEqual(domain.stats?.count, 0)
    }
}
