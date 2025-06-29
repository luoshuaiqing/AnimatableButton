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
            
            FingerprintAnimationView()
            .padding(.bottom, 48)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    ContentView()
}


struct FingerprintAnimationView: View {
    @State private var isPressed = false

    var body: some View {
        ZStack {
            // Background
            if isPressed {
                Color.purple
                    .ignoresSafeArea()
                    .transition(.scale(scale: 0.1, anchor: .center).combined(with: .opacity))
                    .animation(.easeOut(duration: 0.4), value: isPressed)
            }

            // Fingerprint Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "touchid")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(20)
                                    .foregroundColor(.purple)
                            )
                    }
                    .scaleEffect(isPressed ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isPressed)
                    .onLongPressGesture(minimumDuration: 0.1, maximumDistance: .infinity,
                                        pressing: { pressing in
                                            withAnimation {
                                                isPressed = pressing
                                            }
                                        },
                                        perform: { })
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
