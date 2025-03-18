//
//  ProgressView.swift
//  AppGJM
//
//  Created by Francisco Juan on 18/03/25.
//

import SwiftUI

struct CustomProgressView: View {
    @Binding var progress: CGFloat
    var width: CGFloat = 40
    var height: CGFloat = 40

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(.white.opacity(0.9))
                .opacity(0.2)
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(AngularGradient(colors: [.white], center: .center), style: StrokeStyle(lineWidth: 6, lineCap: .butt, lineJoin: .miter))
                .rotationEffect(.degrees(-90))
            
            Text("\(String(format: "%0.0f", progress * 100))%")
                .font(.caption)
            
        }
        .frame(width: width, height: height)
        .animation(.easeInOut, value: progress)
    }
}

#Preview {
    ProgressView()
}
