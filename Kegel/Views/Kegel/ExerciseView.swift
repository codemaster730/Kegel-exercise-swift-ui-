//
//  DayView.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject var modelData: ModelData
    var exercise: Exercise
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(.white)
                .frame(height: 80)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .foregroundColor(Color(hexString: exercise.id == 0 ? modelData.selectedTheme.primaryColor : modelData.selectedTheme.secondColor, alpha: 0.3))
                        .frame(width: 45, height: 45)
                    Image(systemName: exercise.id == 0 ? "text.aligncenter" : "bolt.fill")
                        .resizable()
                        .frame(width: 15, height: 20)
                        .padding(.leading, 2)
                        .foregroundColor(Color(hexString: exercise.id == 0 ? modelData.selectedTheme.primaryColor : modelData.selectedTheme.secondColor))
                        .rotationEffect(Angle(degrees: exercise.id == 0 ? 90 : 0))
                }
                .padding(.leading, 20)
                .padding(.trailing, 10)
                
                VStack (alignment: .leading){
                    Text("\(exercise.tense_time)\" tense, \(exercise.relax_time)\" relax")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 15)
                    Spacer()
                    Text("x\(exercise.repeat_count)")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                        .foregroundColor(Color.black.opacity(0.5))
                    .padding(.bottom, 15)
                }
                Spacer()
                HStack {
                    
                }
                .frame(height: 30)
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        ExerciseView(exercise: modelData.levels[0].days[0].exercises[1]).environmentObject(modelData)
    }
}
