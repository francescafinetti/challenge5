import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("username") private var username: String = "example"
    @State private var notificationsEnabled: Bool = true
    @State private var notificationTime: Date = Date()
    @State private var selectedLanguage: String = "English (USA)"
    @State private var showingDatePicker = false
    @State private var showingLanguagePicker = false
    
    let languages = ["Italiano", "English (USA)", "Français", "Español"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("HOW WOULD YOU LIKE TO BE CALLED?").font(.caption).foregroundColor(.gray)) {
                    TextField("Enter your name", text: $username)
                        .cornerRadius(8)
                }
                
                Section {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Notification")
                        
                    }                         .tint(Color.accent1)

                    
                    if notificationsEnabled {
                        HStack {
                            Text("Notification Time")
                            Spacer()
                            Button(action: {
                                showingDatePicker.toggle()
                            }) {
                                Text(notificationTime, style: .time)
                                    .foregroundColor(.accent1)
                            }
                        }
                        
                        if showingDatePicker {
                            DatePicker("Select Time", selection: $notificationTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("Language")
                        
                        Spacer()
                        Button(action: {
                            showingLanguagePicker.toggle()
                        }) {
                            Text(selectedLanguage)
                                .foregroundColor(.accent1)
                        }
                    }
                    
                    if showingLanguagePicker {
                        Picker("Select Language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                
                Section {
                    NavigationLink(destination: InfoView()) {
                        Text("About")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
                presentationMode.wrappedValue.dismiss()
            })
        } .accentColor(Color.accent1)
    }
}


#Preview {
    SettingsView()
}
