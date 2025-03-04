import SwiftUI

struct GuidedSession: View {
    let selectedPath: String
    @State private var textIndex = 0
    @State private var textTimer: Timer?

    var currentTexts: [String] {
        selectedPath == "Top to Bottom" ? topToBottomTexts : bottomToTopTexts
    }

    var body: some View {
        VStack {
            Image("man")
                .resizable()
                .scaledToFit()

            Text(currentTexts[textIndex])
                .foregroundColor(.white)
                .bold()
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .transition(.opacity)
                .animation(.easeInOut(duration: 3), value: textIndex)
                .padding(.bottom, 70)
                .padding(.horizontal, 20)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            startTextTimer()
        }
        .onDisappear {
            textTimer?.invalidate()
        }
    }

    private func startTextTimer() {
        textTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
            withAnimation {
                textIndex = (textIndex + 1) % currentTexts.count
            }
        }
    }
}

#Preview {
    GuidedSession(selectedPath: "Top to Bottom")
}
