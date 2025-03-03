import SwiftUI
import CoreHaptics

struct StartView: View {
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    @AppStorage("selectedVibrationIntensity") private var selectedVibrationIntensity: String = "Medium"

    @State private var hapticManager = HapticManager()

    var body: some View {
        NavigationStack {
            
                
                VStack(spacing: 30) {
                    StaticIntertwinedCirclesView()
                    Text("Welcome to Your Session")
                        .font(.largeTitle)
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
        } .padding(.bottom, 60)
        }
    }


#Preview {
    StartView()
}
