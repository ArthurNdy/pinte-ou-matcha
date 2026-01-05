import SwiftUI

@main
struct PinteOuMatchaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showMain = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showMain {
                    Image("scene")
                        .resizable()
                        .ignoresSafeArea()
                    ContentView().onAppear {
                        UIDevice.current.setValue(
                            UIInterfaceOrientation.landscapeLeft.rawValue,
                            forKey: "orientation"
                        )
                    }
                } else {
                    Image("splash") // ✅ add "splash" in Assets.xcassets
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .onAppear {
                            // then transition to app
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    showMain = true
                                }
                            }
                        }
                }
                
                
                
                
            }
        }}
}
