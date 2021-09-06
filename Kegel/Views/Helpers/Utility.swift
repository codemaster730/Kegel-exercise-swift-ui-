//
//  Utility.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .top).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


extension AnyTransition {
    static var moveAndFadeLeadingToTrailing: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var moveAndFadeTrailingToLeading: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct CircleProgressBar: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.3)
                .foregroundColor(Color.white)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1)))
                .stroke(style: StrokeStyle(lineWidth: 5.5, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.white)
                .rotationEffect(Angle(degrees: 270.0))
            Text(String(Int(self.progress * 100)) + "%")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}

struct CircleTimerView: View {
    @Binding var progress: Int
    @Binding var total: Int
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .opacity(0.3)
                .foregroundColor(Color.white)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(progress) / Float(total), 1)))
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
            Text("\(total - progress)")
                .font(.system(size: 50))
                .foregroundColor(.black)
                .fontWeight(.bold)
        }
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Color {
    init(hexString: String, alpha: Double = 1) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: (alpha == 1) ? Double(a) / 255 : alpha
        )
    }
    
    init(hexInt: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hexInt >> 16) & 0xff) / 255,
            green: Double((hexInt >> 08) & 0xff) / 255,
            blue: Double((hexInt >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    init(colorName: String, alpha: Double = 1){
        switch colorName{
        case "Pink" :
            self.init(
                .sRGB,
                red: 1,
                green: 192 / 255,
                blue: 203 / 255,
                opacity: alpha
            )
        case "Blue" :
            self.init(
                .sRGB,
                red: 0,
                green: 0,
                blue: 1,
                opacity: alpha
            )
        case "Purple" :
            self.init(
                .sRGB,
                red: 128 / 255,
                green: 0,
                blue: 128 / 255,
                opacity: alpha
            )
        case "Green" :
            self.init(
                .sRGB,
                red: 0,
                green: 1,
                blue: 0,
                opacity: alpha
            )
        default:
            self.init(
                .sRGB,
                red: 1,
                green: 192 / 255,
                blue: 203 / 255,
                opacity: alpha
            )
        }
    }
}
