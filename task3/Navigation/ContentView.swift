import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ImageSwitching()
                } label: {
                    Label("Images", systemImage: "photo")
                }
                NavigationLink {
                    Greeter()
                } label: {
                    Label("Greeter", systemImage: "hand.wave")
                }
            }
            .navigationTitle("Navigation Demo")
        }
    }
}

#Preview {
    ContentView()
}
