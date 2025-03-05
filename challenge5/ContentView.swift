
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var isSettingsPresented = false
    @State private var isPreferencesPresented = false
    @AppStorage("username") private var username: String = "User"

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(currentDateFormatted())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Hello, \(username)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Button(action: {
                        isSettingsPresented.toggle()
                    }) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 25) {
                        NavigationLink(destination: GuidedStartView()) {
                            CardView(title: "Guided Session", subtitle: "4 MIN", icon: "hand.tap.fill", onMoreTapped: {
                                isPreferencesPresented.toggle()
                            })
                        }
                        
                        NavigationLink(destination: StartView()) {
                            CardView(title: "Your Session", subtitle: "-", icon: "hands.sparkles.fill", onMoreTapped: {
                                isPreferencesPresented.toggle()
                            })
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .onAppear(perform: addItemIfEmpty)
            .sheet(isPresented: $isSettingsPresented) {
                SettingsView()
            }
            
            
        } .accentColor(Color.accent1)
    }
    
    private func addItemIfEmpty() {
        if items.isEmpty {
            withAnimation {
                let newItem = Item(timestamp: Date())
                modelContext.insert(newItem)
            }
        }
    }
    
    private func currentDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: Date()).capitalized
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

