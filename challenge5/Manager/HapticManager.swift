import CoreHaptics

class HapticManager {
    private var engine: CHHapticEngine?
    private var breathPlayer: CHHapticAdvancedPatternPlayer?
    private var isPlaying = false

    init() {
        prepareHaptics()
    }

    func prepareHaptics() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic Engine Error: \(error.localizedDescription)")
        }
    }

    func startBreathingHaptic(intensity: String) {
        guard let engine = engine, !isPlaying else { return }
        isPlaying = true

        let intensityValue: Float
        switch intensity {
        case "Soft":
            intensityValue = 0.2
        case "Medium":
            intensityValue = 0.5
        case "Strong":
            intensityValue = 0.8
        default:
            intensityValue = 0.5
        }

        func playHapticPattern() {
            do {
                let pattern = try CHHapticPattern(events: [
                    // Inspirazione - Vibrazione fluida, con intensità crescente a onda
                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.1),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
                    ], relativeTime: 0, duration: 0.5),
                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.3),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
                    ], relativeTime: 0.5, duration: 0.5),
                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.5),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
                    ], relativeTime: 1, duration: 0.5),
                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue * 0.7),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
                    ], relativeTime: 1.5, duration: 1),
                    CHHapticEvent(eventType: .hapticContinuous, parameters: [
                        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue),
                        CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
                    ], relativeTime: 2.5, duration: 1.5),

                    // Espirazione - Piccole vibrazioni rapide e ritmiche (TITITITITI)
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 5.2),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 5.4),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 5.6),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 5.8),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 6.0),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 6.2),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 6.4),
                    CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 6.6)
                ], parameters: [])

                breathPlayer = try engine.makeAdvancedPlayer(with: pattern)
                try breathPlayer?.start(atTime: 0)

                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    if self.isPlaying {
                        playHapticPattern()
                    }
                }

            } catch {
                print("Failed to create haptic pattern: \(error.localizedDescription)")
            }
        }

        playHapticPattern()
    }

    func stopBreathingHaptic() {
        isPlaying = false
        do {
            try breathPlayer?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptic: \(error.localizedDescription)")
        }
    }
}
