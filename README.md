# Pokedex iOS App

A modern iOS application built with SwiftUI that displays a comprehensive list of Pokémon and their detailed information using the PokéAPI. This project was developed using AI generative tools, more specifically, the Cursor app.

## 🚀 Instructions to Run the Application

### Prerequisites
- **Xcode 15.4+** (Latest version recommended)
- **iOS 17.5+** deployment target
- **macOS** with Xcode installed
- **Internet connection** (required for API calls)

### Setup and Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pokedex
   ```

2. **Open the project**
   ```bash
   open Pokedex/Pokedex.xcodeproj
   ```

3. **Build and run**
   - Select your target device or simulator
   - Press `Cmd + R` or click the "Run" button in Xcode
   - The app will build and launch automatically

### Running Tests

1. **Unit Tests**
   ```bash
   # In Xcode: Cmd + U
   # Or via command line:
   xcodebuild test -scheme Pokedex -destination 'platform=iOS Simulator,name=iPhone 15'
   ```

2. **UI Tests**
   - Select the `PokedexUITests` scheme
   - Press `Cmd + U` to run UI tests

## 🏗️ Architectural Overview and Decisions

### Architecture Pattern: MVVM + Clean Architecture

The application follows a **Clean Architecture** approach with **MVVM (Model-View-ViewModel)** pattern, ensuring separation of concerns and testability.

#### Layer Structure:

```
┌─────────────────────────────────────────┐
│                UI Layer                 │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │    Views    │  │   ViewModels    │   │
│  │             │  │                 │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│             Domain Layer                │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │   Models    │  │   Protocols     │   │
│  │             │  │                 │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│            Service Layer                │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │  Services   │  │   Extensions    │   │
│  │             │  │                 │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│             Core Layer                  │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │  Network    │  │   Protocols     │   │
│  │  Service    │  │                 │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
```

### Key Architectural Decisions:

#### 1. **Dependency Injection Container**
- **Decision**: Custom `DependencyContainer` singleton
- **Rationale**: Centralized dependency management, easy testing with mock injection
- **Benefits**: Loose coupling, testability, single source of truth for dependencies

#### 2. **Protocol-Oriented Programming**
- **Decision**: Extensive use of protocols for all service layers
- **Rationale**: Enables easy mocking, testing, and future implementations
- **Example**: `NetworkServiceProtocol`, `PokemonListServiceProtocol`

#### 3. **ViewState Pattern**
- **Decision**: Enum-based view states for UI state management
- **Rationale**: Type-safe state handling, clear UI state transitions
- **Benefits**: Prevents invalid UI states, easier debugging

### Data Flow:

1. **View** triggers action in **ViewModel**
2. **ViewModel** calls **Service** through protocol
3. **Service** uses **NetworkService** to fetch data
4. **Response** is transformed to **Domain Models**
5. **ViewModel** updates **ViewState**
6. **View** reacts to state changes

## 📚 Libraries and Tools Used

### Core Dependencies

#### 1. **Alamofire 5.10.2**
- **Purpose**: HTTP networking library
- **Why**: 
  - Industry standard for iOS networking
  - Excellent error handling and request/response management
  - Built-in support for async/await
  - Comprehensive testing capabilities
- **Usage**: Powering all API calls to PokéAPI

#### 2. **Kingfisher 8.5.0**
- **Purpose**: Image downloading and caching library
- **Why**:
  - Automatic image caching and memory management
  - Smooth image loading with placeholder support
  - Built-in circular image processing
  - Excellent performance for large image sets
- **Usage**: Loading and caching Pokémon sprites

### Development Tools

#### 1. **SwiftUI**
- **Purpose**: Declarative UI framework
- **Why**: 
  - Modern, declarative approach
  - Built-in state management with `@Published` and `@StateObject`
  - Excellent preview capabilities
  - Native iOS integration

#### 2. **Combine Framework**
- **Purpose**: Reactive programming
- **Why**:
  - Native Swift reactive programming
  - Perfect integration with SwiftUI
  - Type-safe publishers and subscribers
  - Built-in error handling

#### 3. **XCTest Framework**
- **Purpose**: Unit and UI testing
- **Why**:
  - Native iOS testing framework
  - Excellent integration with Xcode
  - Support for both unit and UI testing
  - Mock and stub capabilities

### API Integration

#### **PokéAPI (https://pokeapi.co/)**
- **Purpose**: Pokémon data source
- **Why**:
  - Comprehensive Pokémon database
  - Free and reliable
  - RESTful API design
  - Rich data including sprites, stats, and details

## 🔧 What I Would Improve with More Time

### 1. **Improve Navigation System**
- **Current**: Basic native SwiftUI navigation
- **Improvement**:
  - Create a more robust navigation system
  - Use UIHostingController to navigate with UIKit tools
  - Implement a Coordinator pattern to centralize navigation, making it more organized, testable, and easier to understand

### 2. **Enhanced UI/UX Features**
- **Current**: Basic list and detail views
- **Improvement**:
  - Search and filtering capabilities
  - Favorites system with persistence
  - Dark mode support
  - Accessibility improvements (VoiceOver, Dynamic Type)
  - Custom animations and transitions

### 3. **Monitoring & Analytics**
- **Current**: No monitoring
- **Improvement**:
  - Performance monitoring
  - User behavior analytics
  - API response time tracking
  - Error rate monitoring
  - Custom metrics dashboard

## 📱 App Features

- **Pokémon List**: Browse all Pokémon with pagination
- **Pokémon Details**: View detailed information for each Pokémon
- **Image Loading**: Smooth image loading with caching
- **Pull-to-Refresh**: Refresh the Pokémon list
- **Infinite Scroll**: Automatic loading of more Pokémon
- **Splash Screen**: Animated loading screen
- **Error Handling**: Graceful error states

## 🧪 Testing

The project includes comprehensive testing:

- **Unit Tests**: Network service, dependency container, view states
- **UI Tests**: Complete user flow testing
- **Mock Services**: Isolated testing with mock implementations

---
