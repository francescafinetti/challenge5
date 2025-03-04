//INSERIRE VIBRAZIONI - SUONO - DUE BUTTON PER ATTIVARLI E DISATTIVARLI ANCHE QUI COME NELLA YOUR SESSION - CAMBIARE OMINO - END SESSION E SI DEVE TOGLIERE IL BACK


import SwiftUI

struct GuidedSession: View {
    let selectedPath: String
    @State private var textIndex = 0
    @State private var textTimer: Timer?
    @State private var fadeIn = false

    var currentTexts: [String] {
        selectedPath == "Top to Bottom" ? topToBottomTexts : bottomToTopTexts
    }

    var body: some View {
        VStack {
            Image("man")
                .resizable()
                .scaledToFit()
                .opacity(fadeIn ? 1 : 0)
                                .scaleEffect(fadeIn ? 1 : 0.9)
                                .animation(.easeInOut(duration: 1), value: fadeIn)
               

            Text(currentTexts[textIndex])
                .foregroundColor(.white)
                .bold()
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .opacity(fadeIn ? 1 : 0)
                .scaleEffect(fadeIn ? 1 : 0.9)
                .transition(.opacity)
                .animation(.easeInOut(duration: 1), value: fadeIn)
                .padding(.bottom, 70)
                .padding(.horizontal, 20)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            fadeIn = true 
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
