//
//  DayDetailView.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import SwiftUI
import AudioToolbox

struct ProgressBar: View {
    @Binding var value: Float
    var width: CGFloat
    var height: CGFloat
    var color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle().frame(width: width, height: height)
                .opacity(0.2)
                .foregroundColor(color)
            
            Rectangle().frame(width: min(CGFloat(self.value) * width, width), height: height)
                .foregroundColor(color)
                .animation(.linear)
        }
    }
}

struct ExerciseDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    @State var day: Day
    @State var progress: [Float] = [0, 0, 0, 0]
    @State var isTenseRelax: Bool = true
    @State var currentSecond: Int = 0
    @State var restSeconds: Int = 20
    @State var restProgress: Int = 0
    @State var isPlaying: Bool = false
    @State var isWaiting: Bool = false
    @State var isFinished: Bool = false
    @State var isPaused: Bool = false
    @State var showPopup: Bool = false
    @State var showPrivate: Bool = false
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var waitTimer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @Binding var rootIsActive: Bool
    @State private var duration: UInt64 = 0
    @State private var startTime: UInt64 = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea()
            if showPrivate {
                Color.black.opacity(0.95).ignoresSafeArea().zIndex(1.0)
            }
            HStack {
                Spacer()
                Button(action: {
                    showPrivate.toggle()
                }) {
                    Image("ic_switch_private_" + (showPrivate ? "on" : "off"))
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                }
                .padding(.trailing, 20)
            }
            .zIndex(2.0)
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                isPaused = true
                                isPlaying = false
                                stopTimer()
                            }) {
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .frame(width: 25, height: 20)
                            }
                            Spacer()
                        }
                    }
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.leading, 20)
                    
                    if (isWaiting && geometry.size.height > 700) {
                        Text("next")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                            .fontWeight(.bold)
                    }
                    Text("\(day.exercises[day.current_exercise!].tense_time)\" tense, \(day.exercises[day.current_exercise!].relax_time)\" relax")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        .fontWeight(.bold)
                    Text("x\(day.exercises[day.current_exercise!].repeat_count - (isWaiting ? 0 : day.current_repeat!))")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        .fontWeight(.bold)
                        .foregroundColor(isWaiting ? Color.black : Color(hexString: modelData.selectedTheme.repeatColor))

                    HStack {
                        Spacer()
                        if (isWaiting) {
                            ZStack(alignment: .top) {
                                VStack {
                                    Text("\(day.exercises[day.current_exercise!].relax_time)")
                                        .font(.system(size: geometry.size.height > 700 ? geometry.size.width / 4 : geometry.size.width / 5))
                                        .fontWeight(.bold)
                                        .background(
                                            Text("\"")
                                                .font(.system(size: geometry.size.height > 700 ? geometry.size.width / 5 : geometry.size.width / 6))
                                                .offset(x: 35)
                                                .offset(y: -10)
                                        )
                                    Text("relax")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.navTitle.fontSize)))
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color(hexString:  modelData.selectedTheme.secondColor))
                                        .frame(width: geometry.size.height > 700 ? geometry.size.width / 2 : geometry.size.width / 2.1, height: geometry.size.width / 1.8)
                                        .padding(.bottom, -20)
                                )
                                .offset(x: 70)
                                
                                VStack {
                                    Text("\(day.exercises[day.current_exercise!].tense_time)")
                                        .font(.system(size: geometry.size.height > 700 ? geometry.size.width / 4 : geometry.size.width / 5))
                                        .fontWeight(.bold)
                                        .background(
                                            Text("\"")
                                                .font(.system(size: geometry.size.height > 700 ? geometry.size.width / 5 : geometry.size.width / 6))
                                                .offset(x: 35)
                                                .offset(y: -10)
                                        )
                                    Text("tense")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.navTitle.fontSize)))
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color(hexString:  modelData.selectedTheme.primaryColor))
                                        .frame(width: geometry.size.height > 700 ? geometry.size.width / 2 : geometry.size.width / 2.1, height: geometry.size.width / 1.8)
                                        .padding(.bottom, -20)
                                )
                                .offset(x: -70)
                            }
                            .padding(.top, geometry.size.height > 700 ? geometry.size.height / 10 : geometry.size.height / 30)
                        } else {
                            VStack {
                                Text("\(currentSecond)")
                                    .font(.system(size: geometry.size.height > 700 ? geometry.size.width / 4 : geometry.size.width / 5))
                                    .fontWeight(.bold)
                                Text(isTenseRelax ? "tense" : "relax")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(Color(hexString: isTenseRelax ? modelData.selectedTheme.primaryColor : modelData.selectedTheme.secondColor))
                                    .frame(width: geometry.size.height > 700 ? geometry.size.width / 1.8 : geometry.size.width / 2.1, height: geometry.size.width / 1.8)
                                    .padding(.bottom, -20)
                            )
                            .padding(.top, geometry.size.height > 700 ? geometry.size.height / 7 : geometry.size.height / 30)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    if (isWaiting) {
                        HStack {
                            Button(action: {
                                restSeconds += 20
                            }) {
                                Text("+20s")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                    .fontWeight(.bold)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(hexString: modelData.selectedTheme.primaryColor), lineWidth: 3)
                                            .foregroundColor(.white)
                                            .frame(width: 70, height: 40 )
                                    )
                            }
                            Spacer()
                            Button(action: {
                                isPlaying = !isPlaying
                                isPlaying ? startTimer() : stopTimer()
                            }) {
                                CircleTimerView(progress: $restProgress, total: $restSeconds, color: Color(hexString: modelData.selectedTheme.repeatColor))
                                    .frame(width: 110)
                            }
                            .buttonStyle(FlatLinkStyle())
                            Spacer()
                            Button(action: {
                                stopRestAndStart()
                            }) {
                                Text("skip")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                    .fontWeight(.bold)
                                    .offset(x: -10)
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, geometry.size.width / 4)
                    } else {
                        HStack {
                            Button(action: {
                                prevExercise()
                            }) {
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .frame(width: 35, height: 30)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.3))
                                    .padding(10)
                                    .hidden(day.current_exercise == 0)
                            }
                            Spacer()
                            Button(action: {
                                isPlaying = !isPlaying
                                isPlaying ? startTimer() : stopTimer()
                            }) {
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .resizable()
                                    .frame(width: 30, height: 40)
                                    .foregroundColor(.white)
                                    .background(
                                        ZStack {
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 120, height: 120)
                                                .shadow(color: Color.black.opacity(0.1), radius: 7, x: 0, y: 7)
                                            Circle()
                                                .fill(Color(hexString: modelData.selectedTheme.primaryColor))
                                                .frame(width: 90, height: 90)
                                        }
                                            
                                    )
                            }
                            .buttonStyle(FlatLinkStyle())
                            Spacer()
                            Button(action: {
                                nextExercise()
                            }) {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 35, height: 30)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.3))
                                    .padding(10)
                                    .hidden(day.current_exercise! >= day.exercises.count - 1)
                            }
                        }
                        .padding(.horizontal, 50)
                        .padding(.bottom, geometry.size.width / 4)

                        HStack {
                            Button(action: {
                                modelData.userSettings.isVibration = !modelData.userSettings.isVibration
                            }) {
                                Spacer()
                                Image(systemName: !modelData.userSettings.isVibration ? "iphone.radiowaves.left.and.right" : "iphone.slash")
                                    .resizable()
                                    .frame(width: !modelData.userSettings.isVibration ? 30 : 20, height: 25)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                Spacer()
                            }
                            .background(
                                Circle()
                                    .fill(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.2))
                                    .frame(width: 60, height: 60)
                            )
                            Spacer()
                            Button(action: {
                                modelData.userSettings.isVoice = !modelData.userSettings.isVoice
                            }) {
                                Spacer()
                                Image(systemName: !modelData.userSettings.isVoice ? "speaker.2.fill" : "speaker.slash.fill")
                                    .resizable()
                                    .frame(width: 30, height: 25)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                Spacer()
                            }
                            .background(
                                Circle()
                                    .fill(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.2))
                                    .frame(width: 60, height: 60)
                            )
                            Spacer()
                            Button(action: {
                                showPopup.toggle()
                            }) {
                                Spacer()
                                Image(systemName: "text.justifyleft")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                Spacer()
                            }
                            .background(
                                Circle()
                                    .fill(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.2))
                                    .frame(width: 60, height: 60)
                            )
                            .partialSheet(isPresented: $showPopup) {
                                NotePopupView(showModal: $showPopup)
                                    .frame(height: 500)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .topLeading)
                        .background(Color.white)
                        .padding(.bottom, -20)
                    }
                    
                    HStack (spacing: 3) {
                        let width: CGFloat = geometry.size.width * 0.2 - 3
                        ProgressBar(value: $progress[0], width: geometry.size.width * 0.4, height: 10, color: Color(hexString: modelData.selectedTheme.primaryColor))
                        ProgressBar(value: $progress[1], width: width, height: 10, color: Color(hexString: modelData.selectedTheme.secondColor))
                        ProgressBar(value: $progress[2], width: width, height: 10, color: Color(hexString: modelData.selectedTheme.secondColor))
                        ProgressBar(value: $progress[3], width: width, height: 10, color: Color(hexString: modelData.selectedTheme.secondColor))
                    }
                }
            }
            if isPaused {
                Color.black.opacity(0.5).ignoresSafeArea()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isPaused = false
                            isPlaying = true
                            startTimer()
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                .padding(.trailing, 20)
                        }
                    }
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .frame(width: 25, height: 35)
                        .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                    Button(action: {
                        stopExercise()
                    }) {
                        Spacer()
                        Text("quit")
                            .foregroundColor(.white)
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                            .frame(height: 60)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    Button(action: {
                        stopExercise()
                        modelData.sendNotification2(interval: 30 * 60, title: "Kegel", subTitle: "Exercise", body: "It's time to exercise again.")
                    }) {
                        Spacer()
                        Text("come_back_in_30_mins")
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                            .fontWeight(.bold)
                            .underline()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(.white)
                        .frame(height: 250)
                )
                .padding(20)
            }
            NavigationLink(destination: ExerciseFinishView(day: day, shouldPopToRootView: $rootIsActive), isActive: $isFinished) {
                EmptyView()
            }
            .isDetailLink(false)
            .hidden()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear() {
            currentSecond = day.exercises[day.current_exercise!].tense_time
            isTenseRelax = true
            isPlaying = true
            self.startTimer()
            if (day.current_exercise == 0) {
                modelData.playAudio(name: "tense.mp3", language: true) // tense audio
            } else {
                modelData.playAudio(name: "tense-and-relax-quickly.mp3", language: true) // tense and relax quickly audio
            }
            modelData.vibrate()
        }
        .onReceive(timer) { time in
            currentSecond -= 1
            if (currentSecond == 0) {
                if (isTenseRelax) {
                    currentSecond = day.exercises[day.current_exercise!].relax_time
                    isTenseRelax = false
                    if (day.current_exercise == 0) {
                        modelData.playAudio(name: "relax.mp3", language: true) // relax audio
                        modelData.vibrate()
                    }
                } else { // End of repeat
                    day.current_repeat! += 1
                    updateProgress()
                    if (day.current_repeat == day.exercises[day.current_exercise!].repeat_count) { // End of exercise
                        if (day.current_exercise == day.exercises.count - 1) { // End of day
                            self.stopTimer()
                            endExercise()
                            return
                        }

                        nextExercise()
                        return
                    }
                    isTenseRelax = true
                    if (day.current_exercise == 0) {
                        modelData.playAudio(name: "tense.mp3", language: true) // tense audio
                        modelData.vibrate()
                    }
                    currentSecond = day.exercises[day.current_exercise!].tense_time
                }
            }
        }
        .onReceive(waitTimer) { time in
            restProgress += 1
            if (restSeconds - restProgress == 3) {
                modelData.playAudio(name: "3.mp3", language: true)
            } else if (restSeconds - restProgress == 2) {
                modelData.playAudio(name: "2.mp3", language: true)
            } else if (restSeconds - restProgress == 1) {
                modelData.playAudio(name: "1.mp3", language: true)
            }
            if (restProgress >= restSeconds) {
                stopRestAndStart()
            }
        }
    }
    
    func stopExercise() {
        var currentTotalRepeat = 0
        for index in 0..<day.current_exercise! {
            currentTotalRepeat += day.exercises[index].repeat_count
        }
        day.progress = Float(currentTotalRepeat + day.current_repeat!) / Float(day.total_repeat_count)
        
        modelData.updateProgress(day: day, duration: Int(Double(duration) / 1_000_000_000))
        
        rootIsActive = false
    }
    
    func endExercise() {
        day.current_exercise = 0
        day.current_repeat = 0
        day.progress = 1

        modelData.updateProgress(day: day, duration: Int(Double(duration) / 1_000_000_000))
        isFinished = true
        
        modelData.playAudio(name: "td_ding.mp3") // start ding audio
        modelData.playSecondAudio(name: "cheer.mp3") // cheer audio
        modelData.vibrate()
    }
    
    func stopRestAndStart() {
        stopWaitTimer()
        isWaiting = false
        startTimer()
        
        modelData.playAudio(name: "tense-and-relax-quickly.mp3", language: true) // tense and relax quickly audio
        modelData.vibrate()
    }
    
    func updateProgress() {
        for index in 0..<day.current_exercise! {
            progress[index] = 1
        }
        progress[day.current_exercise!] = Float(day.current_repeat!) / Float(day.exercises[day.current_exercise!].repeat_count)
    }
    
    func startTimer() {
        startTime = DispatchTime.now().uptimeNanoseconds
        
        updateProgress()
        
        self.timer = Timer.publish (every: 1, on: .main, in: .common)
        _ = self.timer.connect()
        
        modelData.playSecondAudio(name: "td_ding.mp3") // start ding audio
        modelData.vibrate()
        
        return
    }

    func stopTimer() {
        duration += DispatchTime.now().uptimeNanoseconds - startTime
        
        self.timer.connect().cancel()
        return
    }
    
    func startWaitTimer() {
        startTime = DispatchTime.now().uptimeNanoseconds
            
        self.waitTimer = Timer.publish (every: 1, on: .main, in: .common)
        _ = self.waitTimer.connect()
        
        modelData.playSecondAudio(name: "td_ding.mp3") // start ding audio
        modelData.vibrate()

        return
    }

    func stopWaitTimer() {
        duration += DispatchTime.now().uptimeNanoseconds - startTime
        
        self.waitTimer.connect().cancel()
        return
    }
    
    func nextExercise() {
        if (day.current_exercise! >= day.exercises.count - 1) {
            return
        }
        stopTimer()
        day.current_repeat = 0
        isTenseRelax = true
        day.current_exercise! += 1
        currentSecond = day.exercises[day.current_exercise!].tense_time

        isWaiting = true
        restSeconds = 20
        restProgress = 0
        startWaitTimer()
    }
    
    func prevExercise() {
        stopTimer()
        day.current_repeat = 0
        isTenseRelax = true
        day.current_exercise! -= 1
        currentSecond = day.exercises[day.current_exercise!].tense_time

        if (day.current_exercise == 0) {
            isPlaying = true
            startTimer()
        } else {
            isWaiting = true
            restSeconds = 20
            restProgress = 0
            startWaitTimer()
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static let modelData = ModelData()
    @State static var rootIsActive = false
    static var previews: some View {
        ExerciseDetailView(day: modelData.levels[0].days[0], rootIsActive: $rootIsActive).environmentObject(modelData)
    }
}
