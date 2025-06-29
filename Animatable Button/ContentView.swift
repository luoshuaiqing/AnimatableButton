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
        GeometryReader { geo in
            // Compute a scale large enough for the circle to cover the whole screen
            let buttonDiameter: CGFloat = 80
            let fullScale = sqrt(geo.size.width * geo.size.width +
                                 geo.size.height * geo.size.height) / buttonDiameter

            ZStack(alignment: .bottom) {
                // Expanding circular overlay
                Circle()
                    .fill(Color.purple)
                    .frame(width: buttonDiameter, height: buttonDiameter)
                    .scaleEffect(isPressed ? fullScale : 0.001)
                    .opacity(isPressed ? 1 : 0)
                    .animation(.easeOut(duration: 0.4), value: isPressed)
                    .padding(.bottom, 48)

                // Fingerprint Button
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
                                            withAnimation {
                                                isPressed = pressing
                                            }
                                        },
                                        perform: { })
                    .padding(.bottom, 48)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}
