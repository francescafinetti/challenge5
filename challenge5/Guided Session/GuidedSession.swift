import SwiftUI

struct GuidedSession: View {
    @State private var textguidedIndex = 0

    var body: some View {
        VStack {
            Image("man")
                .resizable()
                .scaledToFit()
            
            Text(textsguided[textguidedIndex])
                .foregroundColor(.white)
                .bold()
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .transition(.opacity)
                .animation(.easeInOut(duration: 3), value: textguidedIndex)
                .padding(.bottom, 70)
                                                .padding(.leading)
                                                .padding(.trailing)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundColor(.white)
    }
}

#Preview {
    GuidedSession()
}
