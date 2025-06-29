//
//  ContentView.swift
//  Animatable Button
//
//  Created by Shuaiqing Luo on 6/29/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    ContentView()
}

struct AnimatedFingerPrintButton: View {
    @State private var isPressed = false
    @State private var holdTimer: Timer?
    @Binding var showText: Bool
    private let buttonDiameter = 88.0
    private let pressDuration = 1.0
    private let color = Color(red: 45 / 255, green: 21 / 255, blue: 73 / 255)

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
                                    guard !showText else { return }
                                    isPressed = pressing
                                    if pressing {
                                        // Start timer when pressed
                                        holdTimer = Timer.scheduledTimer(withTimeInterval: pressDuration, repeats: false) { _ in
                                            withAnimation(.easeInOut(duration: 0.6)) {
                                                showText = true
                                            }
                                        }
                                    } else {
                                        // Cancel timer and hide text when released
                                        holdTimer?.invalidate()
                                        holdTimer = nil
                                        showText = false
                                    }
                                },
                                perform: { })
            .background {
                Circle()
                    .fill(color)
                    .scaleEffect(isPressed ? 20 : 0.001, anchor: .bottom)
                    .offset(y: isPressed ? 100 : 0)
                    .opacity(isPressed ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: isPressed)
            }
    }
}

#Preview {
    @Previewable @State var showText = false

    VStack {
        Spacer()

        AnimatedFingerPrintButton(showText: $showText)
            .padding(.bottom, 48)
    }
}
