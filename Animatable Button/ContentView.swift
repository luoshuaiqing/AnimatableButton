//
//  ContentView.swift
//  Animatable Button
//
//  Created by Shuaiqing Luo on 6/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.black]), center: .center, startRadius: 10, endRadius: 90)
                        )
                        .frame(width: 120, height: 120)
                        .shadow(color: Color.purple.opacity(0.5), radius: 30, x: 0, y: 0)
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 4)
                        .frame(width: 100, height: 100)
                    Image(systemName: "touchid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 48)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    ContentView()
}
