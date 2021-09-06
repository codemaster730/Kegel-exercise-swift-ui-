//
//  StartExerciseView.swift
//  Kegel
//
//  Created by Slav on 14.02.2021.
//

import SwiftUI

struct StartExerciseView: View {
    @Binding var startExercise: Bool
    @Binding var showStartAnimation: Bool
    @EnvironmentObject var modelData: ModelData
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 0.5, on: .main, in: .common)
    @State private var count = 7
    
    var body: some View {
        HStack {
            Text(count % 2 == 0 ? "\(count / 2)" : "")
                .font(.system(size: 100))
                .fontWeight(.bold)
                .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                .transition(.moveAndFade)
                .animation(.easeInOut(duration: 0.5))
                .id("id\(count)")
                .padding(.vertical, 20)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.white.opacity(0.9))
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            _ = timer.connect()
        }
        .onReceive(timer) { time in
            if (count == 6) {
                modelData.playAudio(name: "3.mp3", language: true)
            } else if (count == 4) {
                modelData.playAudio(name: "2.mp3", language: true)
            } else if (count == 2) {
                modelData.playAudio(name: "1.mp3", language: true)
            }
            if (count == 1) {
                timer.connect().cancel()
                startExercise = true
                showStartAnimation = false
            }
            withAnimation() {
                count -= 1
            }
        }
    }
}

struct StartExerciseView_Previews: PreviewProvider {
    @State static var startExercise = false
    @State static var showStartAnimation = false
    static var previews: some View {
        StartExerciseView(startExercise: $startExercise, showStartAnimation: $showStartAnimation)
    }
}
