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
            
            AnimatedFingerPrintButton(buttonDiameter: 88)
                .padding(.bottom, 48)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    ContentView()
}


struct AnimatedFingerPrintButton: View {
    @State private var isPressed = false
    let buttonDiameter: CGFloat

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: buttonDiameter, height: buttonDiameter)
            .overlay(
                Image(systemName: "touchid")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundColor(.purple)
            )
            .scaleEffect(isPressed ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            .onLongPressGesture(minimumDuration: 0.1, maximumDistance: .infinity,
                                pressing: { pressing in
                                    isPressed = pressing
                                },
                                perform: { })
            .overlay {
                Circle()
                    .fill(Color.purple)
                    .scaleEffect(isPressed ? 20 : 0.001, anchor: .bottom)
                    .offset(y: isPressed ? 100 : 0)
                    .opacity(isPressed ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: isPressed)
            }
    }
}
