//
//  CardView.swift
//  challenge5
//
//  Created by Serena Pia Capasso on 24/02/25.
//

import SwiftUI

struct CardView: View {
    
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
    CardView(title: "session", subtitle: "whdeiuhf", icon: "hand.tap.fill")
}
