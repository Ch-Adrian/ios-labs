import SwiftUI

struct Greeter: View {
    @State private var name = ""

    private var greeting: String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Hello, stranger!" : "Hello, \(trimmed.capitalized)!"
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Your name", text: $name, prompt: Text("Your name").italic())
                .textFieldStyle(.roundedBorder)
            Text(greeting)
                .font(.title)
                .bold()
            Spacer()
        }
        .padding()
        .navigationTitle("Greeter")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { Greeter() }
}
