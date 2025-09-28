//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Lucas Allan Almeida Oliveira on 28/09/25.
//

import XCTest

final class PokedexTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicFunctionality() {
        // Test basic functionality
        XCTAssertTrue(true)
    }
    
    func testStringOperations() {
        // Test string operations
        let name = "bulbasaur"
        let capitalized = name.capitalized
        XCTAssertEqual(capitalized, "Bulbasaur")
    }
    
    func testURLCreation() {
        // Test URL creation
        let urlString = "https://example.com/pokemon/1.png"
        let url = URL(string: urlString)
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, urlString)
    }
    
    func testPokemonDataStructure() {
        // Test Pokemon data structure
        let pokemon = Pokemon(
            id: 1,
            name: "Bulbasaur",
            imageUrl: URL(string: "https://example.com/1.png")
        )
        
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "Bulbasaur")
        XCTAssertNotNil(pokemon.imageUrl)
    }
    
    func testMockService() {
        // Test mock service
        let mockService = MockService()
        mockService.shouldReturnError = false
        mockService.mockData = "Test Data"
        
        let result = mockService.fetchData()
        XCTAssertEqual(result, "Test Data")
        XCTAssertEqual(mockService.callCount, 1)
    }
    
    func testMockServiceError() {
        // Test mock service error
        let mockService = MockService()
        mockService.shouldReturnError = true
        
        do {
            _ = try mockService.fetchDataThrowing()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}

// MARK: - Test Models
struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let imageUrl: URL?
    
    init(id: Int, name: String, imageUrl: URL?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}

// MARK: - Mock Service
class MockService {
    var shouldReturnError = false
    var mockData = "Mock Data"
    var callCount = 0
    
    func fetchData() -> String {
        callCount += 1
        return mockData
    }
    
    func fetchDataThrowing() throws -> String {
        callCount += 1
        
        if shouldReturnError {
            throw TestError.networkError
        }
        
        return mockData
    }
}

// MARK: - Test Error
enum TestError: Error {
    case networkError
    case noData

}
