import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading) {
                    Text(currentDateFormatted())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Hello, User")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.primary)
                }
                Spacer()
                Button(action: {
                }) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 15) {
                    CardView(title: "Guided Session", subtitle: "4 MIN", icon: "hand.tap.fill")
                    CardView(title: "Your Session", subtitle: "PERSONALIZED", icon: "hands.sparkles.fill")
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .onAppear(perform: addItemIfEmpty)
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
