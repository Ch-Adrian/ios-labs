import SwiftUI

struct ContentView: View {
    private let images = ["lion", "jungle"]
    @State private var index = 0

    private func changeImage() {
        index = (index + 1) % images.count
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 16) {
                Text("Remember")
                    .font(.system(size: 36, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.purple)
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.height / 5)

                Button(action: changeImage) {
                    Text("Change image")
                        .font(.system(size: 22))
                        .foregroundStyle(.blue)
                }

                Image(images[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
