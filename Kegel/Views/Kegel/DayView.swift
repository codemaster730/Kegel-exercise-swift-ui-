//
//  DayView.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import SwiftUI

struct BarProgressBar: View {
    var progress: Float
    var color: Color
    
    var body: some View {
        ZStack {
            GeometryReader { geometryReader in
                Capsule()
                    .foregroundColor(color.opacity(0.3)) // 4
                    .frame(height: 7)
                    
                Capsule()
                    .frame(width: CGFloat(70 * progress), height: 7) // 5
                    .foregroundColor(color) // 6
                    .animation(.easeIn) // 7
            }
        }
        .frame(width: 70)
        .padding(.trailing, 20)
        .padding(.top, 37)
    }
}

struct DayView: View {
    @EnvironmentObject var modelData: ModelData
    
    var day: Day
    @Binding var selectedLevel: Int
    
    var body: some View {
        ZStack {
            if modelData.levels[selectedLevel].last_day == day.id {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                    .frame(height: 80)
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                        Image(systemName: day.progress! >= 1 ? "checkmark" : "play.fill")
                            .resizable()
                            .frame(width: 15, height: 20)
                            .padding(.leading, 2)
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    
                    VStack (alignment: .leading){
                        Text("day \(day.id + 1)")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 15)
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(Color.white.opacity(0.3))
                            Text(String(format: "%02d:%02d", Int(day.duration / 60), day.duration % 60))
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .foregroundColor(Color.white.opacity(0.3))
                        }
                        .padding(.bottom, 15)
                    }
                    Spacer()
                    if (day.star! > 0) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                            if (day.star! > 1) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                if (day.star! > 2) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                }
                            }
                        }
                        .padding(.trailing, 20)
                    } else {
                        BarProgressBar(progress: day.progress!, color: .white)
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(.white)
                    .frame(height: 80)
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.3))
                            .frame(width: 45, height: 45)
                        Image(systemName: day.progress! >= 1 ? "checkmark" : "play.fill")
                            .resizable()
                            .frame(width: 15, height: 20)
                            .padding(.leading, 2)
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    
                    VStack (alignment: .leading){
                        Text("day \(day.id + 1)")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 15)
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(Color.black.opacity(0.3))
                            Text(String(format: "%02d:%02d", Int(day.duration / 60), day.duration % 60))
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .foregroundColor(Color.black.opacity(0.3))
                        }
                        .padding(.bottom, 15)
                    }
                    Spacer()
                    if (day.star! > 0) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                            if (day.star! > 1) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                if (day.star! > 2) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                }
                            }
                        }
                        .padding(.trailing, 20)
                    } else {
                        BarProgressBar(progress: day.progress!, color: Color(hexString: modelData.selectedTheme.primaryColor))
                    }
                }
            }
        }
        .onAppear() {
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static let modelData = ModelData()
    @State static var selectedLevel = 1
    
    static var previews: some View {
        DayView(day: modelData.levels[0].days[0], selectedLevel: $selectedLevel).environmentObject(modelData)
    }
}
