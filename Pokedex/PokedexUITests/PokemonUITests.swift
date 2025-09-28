import XCTest

class PokemonUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    // MARK: - Basic App Tests
    
    func testAppLaunches() throws {
        // Basic test to verify app launches
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testSplashScreenAppears() throws {
        // Test that splash screen appears on launch
        let splashScreen = app.otherElements["SplashScreenView"]
        XCTAssertTrue(splashScreen.waitForExistence(timeout: 5))
        
        // Test that splash screen has the title
        let title = app.staticTexts["Pokedex"]
        XCTAssertTrue(title.exists)
    }
    
    func testSplashScreenElements() throws {
        // Test splash screen elements
        let splashScreen = app.otherElements["SplashScreenView"]
        XCTAssertTrue(splashScreen.waitForExistence(timeout: 2))
        
        // Test that Pokeball image exists
        let pokeballImage = app.images["PokeballImage"]
        XCTAssertTrue(pokeballImage.exists)
        
        // Test that title exists
        let title = app.staticTexts["Pokedex"]
        XCTAssertTrue(title.exists)
    }
    
    // MARK: - Navigation Tests
    
    func testAppNavigationFlow() throws {
        // Wait for splash screen to appear
        let splashScreen = app.otherElements["SplashScreenView"]
        XCTAssertTrue(splashScreen.waitForExistence(timeout: 2))
        
        // Wait for splash screen to disappear (after animation)
        sleep(3) // Wait for animation to complete
        XCTAssertFalse(splashScreen.exists)
        
        // Test that main content appears
        let mainContent = app.otherElements["ContentView"]
        XCTAssertTrue(mainContent.waitForExistence(timeout: 3))
    }
    
    func testPokemonListUIElements() throws {
        // Wait for splash screen to appear and then disappear
        let splashScreen = app.otherElements["SplashScreenView"]
        XCTAssertTrue(splashScreen.waitForExistence(timeout: 2))
        sleep(3) // Wait for animation to complete
        XCTAssertFalse(splashScreen.exists)
        
        // Test that Pokemon list view appears
        let pokemonListView = app.otherElements["PokemonListView"]
        XCTAssertTrue(pokemonListView.waitForExistence(timeout: 3))
        
        // Test that loading indicator appears initially
        let loadingIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(loadingIndicator.waitForExistence(timeout: 2))
    }
    
    // MARK: - Performance Tests
    
    func testAppLaunchPerformance() throws {
        // Test app launch performance
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
