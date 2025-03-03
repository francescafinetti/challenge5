import SwiftUI

struct PreferencesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("soundEnabled") private var soundEnabled: Bool = true
    @AppStorage("selectedSound") private var selectedSound: String = "Default"
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    @AppStorage("selectedVibrationIntensity") private var selectedVibrationIntensity: String = "Medium"
    
    @State private var isSoundMenuExpanded: Bool = false
    
    let soundOptions = ["Default", "Chime", "Beep", "Melody", "Rain", "Waves", "Forest"]
    let vibrationOptions = ["Soft", "Medium", "Strong"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sound Settings")) {
                    Toggle("Sound", isOn: $soundEnabled)
                    if soundEnabled {
                        DisclosureGroup("Sound Type", isExpanded: $isSoundMenuExpanded) {
                            ForEach(soundOptions, id: \.self) { sound in
                                HStack {
                                    Text(sound)
                                    Spacer()
                                    if selectedSound == sound {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedSound = sound
                                    isSoundMenuExpanded = false
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Vibration Settings")) {
                    Toggle("Vibration", isOn: $vibrationEnabled)
                    if vibrationEnabled {
                        Picker("Vibration Intensity", selection: $selectedVibrationIntensity) {
                            ForEach(vibrationOptions, id: \.self) { intensity in
                                Text(intensity)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationTitle("Preferences")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    PreferencesView()
}
