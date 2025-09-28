# Pokedex iOS App

A modern iOS application built with SwiftUI, using Cursor with ai generative, that displays a list of Pokémon and their detailed information using the PokéAPI.

## 🚀 Features

- **Pokémon List**: Browse through a paginated list of Pokémon
- **Pokémon Details**: View detailed information including types, stats, and images
- **Splash Screen**: Animated splash screen with Pokéball
- **Modern UI**: Built with SwiftUI and follows iOS design guidelines
- **MVVM Architecture**: Clean separation of concerns with ViewModels and Services
- **Network Layer**: Protocol-based networking with Alamofire
- **Image Loading**: Efficient image loading with Kingfisher
- **Comprehensive Testing**: Unit tests and UI tests with mocks

## 🏗️ Architecture

The app follows **MVVM (Model-View-ViewModel)** architecture with the following structure:

```
Pokedex/
├── Core/
│   ├── Protocols/          # Network protocols
│   └── Services/           # Network service implementation
├── Domain/
│   ├── PokemonList/        # Pokemon list domain models
│   └── PokemonDetail/      # Pokemon detail domain models
├── Service/
│   ├── PokemonListService/ # Pokemon list API service
│   ├── PokemonDetailService/ # Pokemon detail API service
│   └── Extensions/         # Response to Domain conversions
└── UI/
    ├── PokemonList/        # Pokemon list views and ViewModels
    ├── PokemonDetail/      # Pokemon detail views and ViewModels
    └── SplashScreen/       # Splash screen view
```

## 📋 Requirements

- **Xcode**: 15.0 or later
- **iOS**: 17.5 or later
- **Swift**: 5.9 or later
- **macOS**: 14.0 or later (for development)

## 🛠️ Dependencies

The project uses Swift Package Manager for dependency management:

- **Alamofire**: 5.10.2 - HTTP networking
- **Kingfisher**: 8.5.0 - Image loading and caching

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd pokedex
```

### 2. Open the Project

```bash
open Pokedex/Pokedex.xcodeproj
```

### 3. Build the Project

#### Using Xcode:
1. Open `Pokedex.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press `Cmd + B` to build the project

#### Using Command Line:
```bash
cd Pokedex
xcodebuild -scheme Pokedex -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### 4. Run the App

#### Using Xcode:
1. Select your target device or simulator
2. Press `Cmd + R` to run the app

#### Using Command Line:
```bash
cd Pokedex
xcodebuild -scheme Pokedex -destination 'platform=iOS Simulator,name=iPhone 15' test
```

## 🧪 Testing

The project includes comprehensive testing with both unit tests and UI tests.

### Test Structure

- **Unit Tests**: `PokedexTests` target
  - Service tests with mocks
  - Data transformation tests
  - Basic functionality tests

- **UI Tests**: `PokedexUITests` target
  - App launch tests
  - Splash screen tests
  - Navigation flow tests
  - Performance tests

### Running Tests

#### Run All Tests:
```bash
cd Pokedex
xcodebuild test -scheme Pokedex -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Test Features

- **Mock Services**: All tests use mock services to avoid real network requests
- **Independent Tests**: Each test is self-contained and doesn't depend on external state
- **Fast Execution**: Tests run quickly without network dependencies
- **Comprehensive Coverage**: Tests cover services, data transformation, and UI interactions

## 🔧 Build Configuration

### Debug Build
```bash
xcodebuild -scheme Pokedex -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Release Build
```bash
xcodebuild -scheme Pokedex -configuration Release -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Clean Build
```bash
xcodebuild clean -scheme Pokedex
```

## 📱 Supported Devices

- **iPhone**: All iPhone models running iOS 17.5+
- **iPad**: All iPad models running iOS 17.5+
- **Simulator**: All iOS Simulator devices

## 🐛 Troubleshooting

### Common Issues

1. **Build Errors**: Clean the build folder (`Cmd + Shift + K` in Xcode)
2. **Simulator Issues**: Reset simulator or create a new one
3. **Dependency Issues**: Update Swift Package Manager dependencies
4. **Test Failures**: Ensure all dependencies are properly installed

### Clean Build
```bash
cd Pokedex
xcodebuild clean -scheme Pokedex
rm -rf ~/Library/Developer/Xcode/DerivedData/Pokedex-*
```

## 📊 Performance

- **App Launch Time**: Optimized with splash screen
- **Image Loading**: Efficient caching with Kingfisher
- **Memory Usage**: Optimized for smooth scrolling
- **Network**: Efficient API calls with pagination

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **PokéAPI**: For providing the Pokémon data
- **Alamofire**: For HTTP networking
- **Kingfisher**: For image loading and caching
- **SwiftUI**: For the modern UI framework
