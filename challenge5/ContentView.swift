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
                    SessionCardView(title: "Guided Session", subtitle: "4 MIN", icon: "hand.tap.fill")
                    SessionCardView(title: "Your Session", subtitle: "PERSONALIZED", icon: "hands.sparkles.fill")
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
                    .frame(height: 50)
                    .foregroundColor(.accent1)
                    .padding(.top)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.accent1)
                    Text(subtitle)
                        .foregroundColor(.accent1)
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
            
            Button(action: {
            }) {
                Circle()
                    .fill(Color(.accent1))
                    .opacity(15/100)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "ellipsis")
                            .foregroundColor(.accent1)
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
