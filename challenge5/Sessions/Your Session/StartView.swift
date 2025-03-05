import SwiftUI
import CoreHaptics

struct StartView: View {
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    @AppStorage("selectedVibrationIntensity") private var selectedVibrationIntensity: String = "Medium"

    @State private var hapticManager = HapticManager()
    @State private var isAnimating = false

    var body: some View {
        NavigationStack {
       
                VStack(spacing: 30) {
                    
                    Image("prova")
                                .resizable()
                                .scaledToFit()
                                .frame(width: isAnimating ? 220 : 250, height: isAnimating ? 220 : 250)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                                .onAppear {
                                    isAnimating = true
                                } .padding(.top, 150)
                    Text("Welcome to \nYour Session")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    Text("Take a deep breath and begin when you're ready.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    NavigationLink(destination: IntertwinedCirclesView(hapticManager: hapticManager)) {
                        Text("Start")
                            .font(.title2)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accent1)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding(.horizontal, 40)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                                        if vibrationEnabled {
                                            hapticManager.startBreathingHaptic(intensity: selectedVibrationIntensity)
                                        }
                    })

                    Spacer()
                }
        } .padding(.bottom, 30)
        }
    }


#Preview {
    StartView()
}
