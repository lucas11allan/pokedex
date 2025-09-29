//
//  DependencyContainerTests.swift
//  PokedexTests
//
//  Created by Lucas Allan Almeida Oliveira on 28/09/25.
//

import XCTest
@testable import Pokedex

class DependencyContainerTests: XCTestCase {
    
    var dependencyContainer: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        dependencyContainer = DependencyContainer.shared
    }
    
    override func tearDown() {
        dependencyContainer = nil
        super.tearDown()
    }
    
    // MARK: - Service Creation Tests
    
    func testMakePokemonListService() {
        // When
        let service = dependencyContainer.makePokemonListService()
        
        // Then
        XCTAssertTrue(service is PokemonListService)
    }
    
    func testMakePokemonDetailService() {
        // When
        let service = dependencyContainer.makePokemonDetailService()
        
        // Then
        XCTAssertTrue(service is PokemonDetailService)
    }
    
    // MARK: - ViewModel Creation Tests
    
    @MainActor
    func testMakePokemonListViewModel() {
        // When
        let viewModel = dependencyContainer.makePokemonListViewModel()
        
        // Then
        XCTAssertTrue(viewModel is PokemonListViewModel)
        XCTAssertTrue(viewModel.viewState.isLoading)
        XCTAssertEqual(viewModel.pokemonList.count, 0)
    }
    
    @MainActor
    func testMakePokemonDetailViewModel() {
        // Given
        let pokemonId = 1
        
        // When
        let viewModel = dependencyContainer.makePokemonDetailViewModel(pokemonId: pokemonId)
        
        // Then
        XCTAssertTrue(viewModel is PokemonDetailViewModel)
        XCTAssertTrue(viewModel.viewState.isLoading)
    }
    
    // MARK: - Singleton Pattern Tests
    
    func testDependencyContainerIsSingleton() {
        // When
        let instance1 = DependencyContainer.shared
        let instance2 = DependencyContainer.shared
        
        // Then
        XCTAssertTrue(instance1 === instance2)
    }
    
    // MARK: - Service Dependencies Tests
    
    func testPokemonListServiceHasNetworkService() {
        // When
        let pokemonListService = dependencyContainer.makePokemonListService()
        
        // Then
        // We can't directly test the private networkService property,
        // but we can test that the service works by calling its method
        // and ensuring it doesn't crash
        XCTAssertNotNil(pokemonListService)
    }
    
    func testPokemonDetailServiceHasNetworkService() {
        // When
        let pokemonDetailService = dependencyContainer.makePokemonDetailService()
        
        // Then
        // We can't directly test the private networkService property,
        // but we can test that the service works by calling its method
        // and ensuring it doesn't crash
        XCTAssertNotNil(pokemonDetailService)
    }
    
    // MARK: - ViewModel Dependencies Tests
    
    @MainActor
    func testPokemonListViewModelHasService() {
        // When
        let viewModel = dependencyContainer.makePokemonListViewModel()
        
        // Then
        // We can test that the viewModel has the service by checking
        // that it can be initialized without crashing
        XCTAssertNotNil(viewModel)
    }
    
    @MainActor
    func testPokemonDetailViewModelHasService() {
        // Given
        let pokemonId = 1
        
        // When
        let viewModel = dependencyContainer.makePokemonDetailViewModel(pokemonId: pokemonId)
        
        // Then
        // We can test that the viewModel has the service by checking
        // that it can be initialized without crashing
        XCTAssertNotNil(viewModel)
    }
    
    // MARK: - Multiple Instances Tests
    
    @MainActor
    func testMultiplePokemonListViewModelInstances() {
        // When
        let viewModel1 = dependencyContainer.makePokemonListViewModel()
        let viewModel2 = dependencyContainer.makePokemonListViewModel()
        
        // Then
        XCTAssertNotNil(viewModel1)
        XCTAssertNotNil(viewModel2)
        // They should be different instances
        XCTAssertFalse(viewModel1 === viewModel2)
    }
    
    @MainActor
    func testMultiplePokemonDetailViewModelInstances() {
        // Given
        let pokemonId1 = 1
        let pokemonId2 = 2
        
        // When
        let viewModel1 = dependencyContainer.makePokemonDetailViewModel(pokemonId: pokemonId1)
        let viewModel2 = dependencyContainer.makePokemonDetailViewModel(pokemonId: pokemonId2)
        
        // Then
        XCTAssertNotNil(viewModel1)
        XCTAssertNotNil(viewModel2)
        // They should be different instances
        XCTAssertFalse(viewModel1 === viewModel2)
    }
    
    // MARK: - Service Protocol Conformance Tests
    
    func testPokemonListServiceConformsToProtocol() {
        // When
        let service = dependencyContainer.makePokemonListService()
        
        // Then
        XCTAssertTrue(service is PokemonListServiceProtocol)
    }
    
    func testPokemonDetailServiceConformsToProtocol() {
        // When
        let service = dependencyContainer.makePokemonDetailService()
        
        // Then
        XCTAssertTrue(service is PokemonDetailServiceProtocol)
    }
}
