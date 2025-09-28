import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var showMainApp = false
    
    var body: some View {
        if showMainApp {
            ContentView()
        } else {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.red.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Pokeball Image
                    PokeballView()
                        .scaleEffect(isAnimating ? 1.1 : 0.8)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            Animation.easeInOut(duration: 2.0)
                                .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                    
                    // Title
                    Text("POKEDEX")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(
                            Animation.easeInOut(duration: 1.5)
                                .delay(0.5),
                            value: isAnimating
                        )
                    
                    // Loading indicator
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .animation(
                            Animation.easeInOut(duration: 1.0)
                                .delay(1.0),
                            value: isAnimating
                        )
                }
            }
            .onAppear {
                isAnimating = true
                
                // Simulate loading time
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showMainApp = true
                    }
                }
            }
        }
    }
}

struct PokeballView: View {
    var body: some View {
        ZStack {
            // Outer circle (white)
            Circle()
                .fill(Color.white)
                .frame(width: 120, height: 120)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            
            // Top half (red)
            Circle()
                .fill(Color.red)
                .frame(width: 120, height: 120)
                .clipShape(
                    Rectangle()
                        .offset(y: -60)
                )
            
            // Bottom half (white) - already covered by outer circle
            
            // Center line
            Rectangle()
                .fill(Color.black)
                .frame(width: 120, height: 4)
            
            // Center button
            Circle()
                .fill(Color.white)
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
                .overlay(
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 20, height: 20)
                )
        }
    }
}

#Preview {
    SplashScreenView()
}
