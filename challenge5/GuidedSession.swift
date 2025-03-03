import SwiftUI

struct GuidedSession: View {
    var body: some View {
        VStack {
            Image("ciro")
                .resizable()
                .scaledToFit()
            Text("Guided Session")
                .font(.largeTitle)
                .bold()
                .padding(.top, 50)

            Text("This is a placeholder for your guided session content.")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundColor(.white)
    }
}

#Preview {
    GuidedSession()
}
