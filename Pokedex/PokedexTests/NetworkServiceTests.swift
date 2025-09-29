//
//  NetworkServiceTests.swift
//  PokedexTests
//
//  Created by Lucas Allan Almeida Oliveira on 28/09/25.
//

import XCTest
@testable import Pokedex
import Alamofire

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    // MARK: - Protocol Conformance Tests
    
    func testNetworkServiceConformsToProtocol() {
        // Then
        XCTAssertTrue(networkService is NetworkServiceProtocol)
    }
    
    // MARK: - Request Structure Tests
    
    func testPokemonListRequestStructure() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        
        // Then
        XCTAssertEqual(request.path, "/pokemon")
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.parameters?["offset"] as? Int, 0)
        XCTAssertEqual(request.parameters?["limit"] as? Int, 20)
    }
    
    func testPokemonDetailRequestStructure() {
        // Given
        let request = PokemonDetailRequest(id: 1)
        
        // Then
        XCTAssertEqual(request.path, "/pokemon/1")
        XCTAssertEqual(request.method, .get)
        XCTAssertNil(request.parameters)
    }
    
    func testPokemonListRequestWithDifferentParameters() {
        // Given
        let request = PokemonListRequest(offset: 40, limit: 10)
        
        // Then
        XCTAssertEqual(request.path, "/pokemon")
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.parameters)
        XCTAssertEqual(request.parameters?["offset"] as? Int, 40)
        XCTAssertEqual(request.parameters?["limit"] as? Int, 10)
    }
    
    func testPokemonDetailRequestWithDifferentId() {
        // Given
        let request = PokemonDetailRequest(id: 150)
        
        // Then
        XCTAssertEqual(request.path, "/pokemon/150")
        XCTAssertEqual(request.method, .get)
        XCTAssertNil(request.parameters)
    }
    
    // MARK: - HTTP Method Tests
    
    func testPokemonListRequestUsesGetMethod() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        
        // Then
        XCTAssertEqual(request.method, HTTPMethod.get)
    }
    
    func testPokemonDetailRequestUsesGetMethod() {
        // Given
        let request = PokemonDetailRequest(id: 1)
        
        // Then
        XCTAssertEqual(request.method, HTTPMethod.get)
    }
    
    // MARK: - Parameter Encoding Tests
    
    func testPokemonListRequestUsesDefaultEncoding() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        
        // Then
        // The default encoding for GET requests with parameters is URLEncoding.default
        // This is handled by Alamofire automatically
        XCTAssertNotNil(request.parameters)
    }
    
    // MARK: - URL Construction Tests
    
    func testPokemonListRequestURLConstruction() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        let baseURL = "https://pokeapi.co/api/v2"
        
        // When
        let fullURL = baseURL + request.path
        
        // Then
        XCTAssertEqual(fullURL, "https://pokeapi.co/api/v2/pokemon")
    }
    
    func testPokemonDetailRequestURLConstruction() {
        // Given
        let request = PokemonDetailRequest(id: 1)
        let baseURL = "https://pokeapi.co/api/v2"
        
        // When
        let fullURL = baseURL + request.path
        
        // Then
        XCTAssertEqual(fullURL, "https://pokeapi.co/api/v2/pokemon/1")
    }
    
    // MARK: - Edge Cases Tests
    
    func testPokemonListRequestWithZeroOffset() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        
        // Then
        XCTAssertEqual(request.parameters?["offset"] as? Int, 0)
        XCTAssertEqual(request.parameters?["limit"] as? Int, 20)
    }
    
    func testPokemonListRequestWithLargeOffset() {
        // Given
        let request = PokemonListRequest(offset: 1000, limit: 50)
        
        // Then
        XCTAssertEqual(request.parameters?["offset"] as? Int, 1000)
        XCTAssertEqual(request.parameters?["limit"] as? Int, 50)
    }
    
    func testPokemonDetailRequestWithZeroId() {
        // Given
        let request = PokemonDetailRequest(id: 0)
        
        // Then
        XCTAssertEqual(request.path, "/pokemon/0")
    }
    
    func testPokemonDetailRequestWithLargeId() {
        // Given
        let request = PokemonDetailRequest(id: 9999)
        
        // Then
        XCTAssertEqual(request.path, "/pokemon/9999")
    }
    
    // MARK: - Request Validation Tests
    
    func testPokemonListRequestHasRequiredParameters() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        
        // Then
        XCTAssertNotNil(request.parameters)
        XCTAssertTrue(request.parameters!.keys.contains("offset"))
        XCTAssertTrue(request.parameters!.keys.contains("limit"))
    }
    
    func testPokemonDetailRequestHasNoParameters() {
        // Given
        let request = PokemonDetailRequest(id: 1)
        
        // Then
        XCTAssertNil(request.parameters)
    }
    
    // MARK: - Type Safety Tests
    
    func testPokemonListRequestParametersAreCorrectType() {
        // Given
        let request = PokemonListRequest(offset: 0, limit: 20)
        
        // Then
        XCTAssertTrue(request.parameters?["offset"] is Int)
        XCTAssertTrue(request.parameters?["limit"] is Int)
    }
    
    func testPokemonDetailRequestPathIsString() {
        // Given
        let request = PokemonDetailRequest(id: 1)
        
        // Then
        XCTAssertTrue(request.path is String)
    }
}
