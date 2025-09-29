import SwiftUI
import Kingfisher

struct PokemonListView: View {
    @StateObject private var viewModel = DependencyContainer.shared.makePokemonListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView("Loading Pokemons...")
                        .accessibilityIdentifier("LoadingIndicator")
                case .success(let pokemons):
                    List(pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemonId: pokemon.id)) {
                            HStack {
                                KFImage(pokemon.imageUrl)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                Text(pokemon.name.capitalized)
                            }
                        }
                        .onAppear {
                            if pokemon.id == pokemons.last?.id {
                                viewModel.loadMorePokemon()
                            }
                        }
                    }
                    .navigationTitle("Pokedex")
                    .refreshable {
                        viewModel.refreshPokemonList()
                    }
                case .error(let error):
                    Text("Error: \(error.localizedDescription)")
                }
            }
            .accessibilityIdentifier("PokemonListView")
            .onAppear {
                viewModel.loadPokemonList()
            }
        }
    }
}

#Preview {
    PokemonListView()
}
