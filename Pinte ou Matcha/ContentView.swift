import SwiftUI

struct ContentView: View {
    // -1 = beer winning, +1 = matcha winning
    @State private var progress: CGFloat = 0
    @State private var blinkBeer = false
    
    var beerMeter: CGFloat {
        if progress < 0 {
            return abs(progress)
        }
        return 0
    }
    
    var matchaMeter: CGFloat {
        if progress > 0 {
            return progress
        }
        return 0
    }
    
    var body: some View {
        ZStack {
            Image("flag")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 256)
            
            VStack {
                Spacer()
                HStack(spacing: 200) {
                    Text("\(Int(beerMeter)) / 5")
                        .frame(maxWidth: .infinity)
                    Text("\(Int(matchaMeter)) / 5")
                        .frame(maxWidth: .infinity)
                }.bold()
                .padding(.horizontal)
                Spacer()
                
                Image("contest")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .offset(x: progress * 30)
                    .animation(
                        .spring(response: 0.28, dampingFraction: 0.75),
                        value: progress
                    )
                Spacer()
                HStack(spacing: 40) {
                    Button {
                        nudge(by: -1)
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Pull beer")
                                .bold()
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                    
                     Button {
                        reset()
                    } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")                .frame(minHeight: 40)
                            .padding(.horizontal, 20)
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(abs(progress) == 5 ? .white : .accentColor)
                    
                    Button {
                        nudge(by: 1)
                    } label: {
                        HStack {
                            Text("Pull matcha")
                                .bold()
                            Image(systemName: "arrow.right")
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    
                }
                .padding(.horizontal)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            winOverlay
        }
    }
    
    // MARK: - Progress logic
    private func nudge(by delta: CGFloat) {
        progress = progress + delta
    }
    
    private func reset() {
        progress = 0
    }
    
    private enum Winner { case beer, matcha }
    
    private var winner: Winner? {
        if beerMeter >= 5 { return .beer }
        if matchaMeter >= 5 { return .matcha }
        return nil
    }
    
    @ViewBuilder
    private var winOverlay: some View {
        if let winner {
            ZStack {
                // colored tint
                (winner == .matcha ? Color.green : Color.yellow)
                    .opacity(0.35)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Text(winner == .matcha ? "🍵 Matcha wins!" : "🍺 Beer wins!")
                        .font(.system(size: 40, weight: .heavy))
                    
                    Text("Tap reset to play again")
                        .font(.title3)
                    
                    Button { reset() } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                            .bold()
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(winner == .matcha ? .green : .yellow)
                }
                .padding(24)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            }
            .transition(.opacity)
        }}}
    
#Preview {
    ContentView()
}
