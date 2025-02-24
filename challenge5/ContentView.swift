import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
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
                    // Action for settings
                }) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            
            // Cards List
            ScrollView {
                VStack(spacing: 15) {
                    SessionCardView(title: "Guided Session", subtitle: "4 MIN", icon: "hand.tap")
                    SessionCardView(title: "Your Session", subtitle: "PERSONALIZED", icon: "hand.wave")
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

struct SessionCardView: View {
    var title: String
    var subtitle: String
    var icon: String
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .foregroundColor(.yellow)
                    .padding(.top)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.yellow)
                    Text(subtitle)
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                .multilineTextAlignment(.center)
                
                Text("Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.bottom)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            
            // Three dots button styled as in the image
            Button(action: {
                // Action for more options
            }) {
                Circle()
                    .fill(Color(.yellow))
                    .opacity(15/100)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "ellipsis")
                            .foregroundColor(.yellow)
                    )
                    .padding(10)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
