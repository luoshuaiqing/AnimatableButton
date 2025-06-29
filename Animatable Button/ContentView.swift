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
    @GestureState private var isDetectingLongPress = false

    var body: some View {
        ZStack {
            // Background
            if isPressed || isDetectingLongPress {
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
                    .scaleEffect(isDetectingLongPress ? 1.2 : 1.0)
                    .gesture(
                        LongPressGesture(minimumDuration: 0.1)
                            .updating($isDetectingLongPress) { currentState, gestureState, _ in
                                gestureState = currentState
                            }
                            .onEnded { _ in
                                withAnimation {
                                    isPressed = true
                                }
                            }
                    )
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { _ in
                                withAnimation {
                                    isPressed = false
                                }
                            }
                    )
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
