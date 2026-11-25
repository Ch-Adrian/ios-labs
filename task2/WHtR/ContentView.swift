import SwiftUI

struct ContentView: View {
    @State private var waistText = ""
    @State private var heightText = ""
    @State private var resultText = ""
    @State private var interpretation = ""
    @State private var showError = false
    @State private var errorText = ""

    /// Parses a positive number; accepts both "." and "," as decimal separator.
    private func parse(_ text: String, field: String) -> Double? {
        let trimmed = text.trimmingCharacters(in: .whitespaces)
        if trimmed.isEmpty {
            fail("Pole „\(field)” jest puste.")
            return nil
        }
        guard let value = Double(trimmed.replacingOccurrences(of: ",", with: ".")),
              value.isFinite else {
            fail("Pole „\(field)” musi zawierać liczbę, a nie tekst.")
            return nil
        }
        guard value > 0 else {
            fail("Pole „\(field)” musi być liczbą dodatnią.")
            return nil
        }
        return value
    }

    private func fail(_ message: String) {
        errorText = message
        showError = true
        resultText = ""
        interpretation = ""
    }

    private func calculate() {
        guard let waist = parse(waistText, field: "Obwód w pasie"),
              let height = parse(heightText, field: "Wzrost") else { return }
        // height > 0 is guaranteed by validation, so no division by zero
        let ratio = waist / height
        resultText = String(format: "WHtR = %.2f", ratio)
        switch ratio {
        case ..<0.4: interpretation = "Poniżej normy (zbyt szczupła sylwetka)"
        case ..<0.5: interpretation = "Prawidłowy"
        case ..<0.6: interpretation = "Zwiększone ryzyko zdrowotne"
        default: interpretation = "Wysokie ryzyko zdrowotne"
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Kalkulator WHtR")
                .font(.largeTitle.bold())
            Text("Stosunek obwodu w pasie do wzrostu")
                .foregroundStyle(.secondary)

            VStack(spacing: 12) {
                TextField("Obwód w pasie [cm]", text: $waistText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Wzrost [cm]", text: $heightText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }

            Button(action: calculate) {
                Text("Oblicz")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            if !resultText.isEmpty {
                VStack(spacing: 6) {
                    Text(resultText).font(.title2.bold())
                    Text(interpretation).foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .padding()
        .alert("Błąd danych", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorText)
        }
    }
}

#Preview {
    ContentView()
}
