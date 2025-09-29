import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    let pokemonId: Int
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
        self._viewModel = StateObject(wrappedValue: DependencyContainer.shared.makePokemonDetailViewModel(pokemonId: pokemonId))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView("Loading Pokemon details...")
                case .success(let pokemon):
                    KFImage(pokemon.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    if let types = pokemon.types {
                        HStack {
                            ForEach(types, id: \.slot) { pokemonType in
                                Text(pokemonType.type.name.capitalized)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Capsule().fill(Color.blue))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    if let stats = pokemon.stats {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Base Stats")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            ForEach(stats, id: \.stat.name) { pokemonStat in
                                HStack {
                                    Text("\(pokemonStat.stat.name.capitalized):")
                                        .frame(width: 100, alignment: .leading)
                                    ProgressView(value: Double(pokemonStat.baseStat), total: 150)
                                        .accentColor(Color.green)
                                    Text("\(pokemonStat.baseStat)")
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(
                                cornerRadius: 10
                            ).fill(Color.gray.opacity(0.1))
                        )
                        .padding(.horizontal)
                    }
                case .error(let error):
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text("Error: \(error.localizedDescription)")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button("Retry") {
                            viewModel.retryLoadPokemon()
                        }
                        .buttonStyle(.borderedProminent)
                        .accessibilityIdentifier("RetryButton")
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Pokemon Detail")
        .onAppear {
            viewModel.loadPokemon()
        }
    }
}

#Preview {
    PokemonDetailView(pokemonId: 1)
}
