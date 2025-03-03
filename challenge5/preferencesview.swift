import SwiftUI

struct PreferencesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var soundEnabled: Bool = true
    @State private var vibrationEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Sound", isOn: $soundEnabled)
                    Toggle("Vibration", isOn: $vibrationEnabled)
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
