import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading) {
                    Text(Date().formatted(date: .long, time: .omitted).uppercased())
                        .font(.caption)
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
}

struct SessionCardView: View {
    var title: String
    var subtitle: String
    var icon: String
    
    var body: some View {
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
            
            HStack {
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
