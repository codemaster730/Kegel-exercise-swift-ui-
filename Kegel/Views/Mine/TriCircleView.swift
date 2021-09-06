//
//  TriCircleView.swift
//  Kegel
//
//  Created by Slav on 17.02.2021.
//

import SwiftUI

struct TriCircleView: View {
    var lineWidth: Double
    var color: Color
    var progress: Int
    
    var body: some View {
        ZStack {
            if (progress > 0) {
                if (progress == 1 || progress == 2) {
                    Circle()
                        .stroke(lineWidth: CGFloat(self.lineWidth))
                        .opacity(0.2)
                        .foregroundColor(color)
                }
                
                if (progress == 1 || progress == 2) {
                    Circle()
                        .trim(from: 0.025, to: CGFloat(0.305))
                        .stroke(style: StrokeStyle(lineWidth: CGFloat(self.lineWidth), lineCap: .round, lineJoin: .round))
                        .foregroundColor(color)
                        .rotationEffect(Angle(degrees: 270.0))
                }
                
                if (progress == 2) {
                    Circle()
                        .trim(from: 0.025, to: CGFloat(0.305))
                        .stroke(style: StrokeStyle(lineWidth: CGFloat(self.lineWidth), lineCap: .round, lineJoin: .round))
                        .foregroundColor(color)
                        .rotationEffect(Angle(degrees: 30))
                }
                
                if (progress >= 3) {
                    Circle()
                        .stroke(lineWidth: CGFloat(self.lineWidth))
                        .foregroundColor(color)
                }
            }
        }
    }
}

struct TriCircleView_Previews: PreviewProvider {
    static var previews: some View {
        TriCircleView(lineWidth: 10, color: Color.red, progress: 3)
    }
}
