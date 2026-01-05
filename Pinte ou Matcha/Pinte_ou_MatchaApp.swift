import SwiftUI

@main
struct Pinte_ou_MatchaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                ContentView()
            }
            .onAppear {
                UIDevice.current.setValue(
                    UIInterfaceOrientation.landscapeLeft.rawValue,
                    forKey: "orientation"
                )
            }
        }
    }
}
