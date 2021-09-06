//
//  ModelData.swift
//  Landmarks
//
//  Created by A on 04.02.2021.
//

import Foundation
import Combine
import AVFoundation
import UserNotifications

final class ModelData: ObservableObject {
    @Published var userSettings = UserSettings()
    @Published var theme: [ThemeData] = load("themeData.json")
    @Published private var femaleLevels: [Level] = load("femaleLevelData.json")
    @Published private var maleLevels: [Level] = load("femaleLevelData.json")
    @Published var _levels: [Level] = []
    @Published var _history: [Exercised] = []
    var isHistoryLoaded = false
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    func sendNotification2(interval: Int, title: String, subTitle: String, body: String) {
        let date = Calendar.current.date(byAdding: .second, value: interval, to: Date())!
        let dateComponents = DateComponents(hour: Calendar.current.component(.hour, from: date), minute: Calendar.current.component(.minute, from: date), second: Calendar.current.component(.second, from: date))
        sendNotification(date: dateComponents, title: title, subTitle: subTitle, body: body, repeat: false)
    }
    
    func sendNotification(interval: Int, title: String, subTitle: String, body: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
                success, error in
            if success {
                print("authorization granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
            
        let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subTitle
            content.body = body
            content.sound = UNNotificationSound.default
        
        let imageName = "ic_launcher"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
               
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString + title, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelAllNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func scheduleReminders() {
        cancelAllNotification()
        for reminder in userSettings.reminders {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let date = dateFormatter.date(from: reminder)
            
            let dateComponents = DateComponents(hour: Calendar.current.component(.hour, from: date!), minute: Calendar.current.component(.minute, from: date!))
            sendNotification(date: dateComponents, title: "Kegel", subTitle: "Exercise", body: "It's time to exercise")
        }
    }
    
    func sendNotification(date: DateComponents, title: String, subTitle: String, body: String, repeat: Bool = true) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
                success, error in
            if success {
                print("authorization granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
            
        let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subTitle
            content.body = body
            content.sound = UNNotificationSound.default
        
        let imageName = "ic_launcher"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
               
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString + title, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    func playAudio(name: String, language: Bool = false) {
        if (userSettings.isVoice == true) {
            return
        }
        
        var fileName = name
        if (language == true) {
            fileName = userSettings.selectedLanguage + "_" + name
        }
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Can't find the audio file!")
        }
    }
    
    func playSecondAudio(name: String, language: Bool = false) {
        if (userSettings.isVoice == true) {
            return
        }
            
        var fileName = name
        if (language == true) {
            fileName = userSettings.selectedLanguage + "_" + name
        }
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: url)
            audioPlayer2?.play()
        } catch {
            print("Can't find the audio file!")
        }
    }
    
    func vibrate() {
        if (userSettings.isVibration == false) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    private var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    var levels: [Level] {
        get {
            if (_levels.count == 0) {
                loadLevelData()
            }
            return _levels
        }
        set (new) {
            _levels = new
        }
    }
    
    var history: [Exercised] {
        get {
            if (isHistoryLoaded == false) {
                loadHistoryData()
            }
            return _history
        }
        set (new) {
            _history = new
        }
    }
    
    private var fileURL: URL {
        return documentsFolder.appendingPathComponent(userSettings.gender == true ? "level.data" : "flevel.data")
    }
    
    private var historyFileURL: URL {
        return documentsFolder.appendingPathComponent("history.data")
    }
    
    func loadLevelData() {
        if (isHistoryLoaded == false) {
            loadHistoryData()
            isHistoryLoaded = true
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            self._levels = userSettings.gender == true ? maleLevels : femaleLevels
            return
        }
        guard let levelData = try? JSONDecoder().decode([Level].self, from: data) else {
            fatalError("Can't decode saved level data.")
        }
        self._levels = levelData
    }
    
    func saveLevelData() {
        guard let data = try? JSONEncoder().encode(levels) else { fatalError("Error encoding data") }
        do {
            let outfile = fileURL
            try data.write(to: outfile)
        } catch {
            fatalError("Can't write to file")
        }
    }
    
    func updateProgress(day: Day, duration: Int) {
        if (day.progress! >= 1) {
            levels[day.level!].days[day.id].star! += 1
            levels[day.level!].days[day.id].progress = 0
        } else {
            levels[day.level!].days[day.id].progress = day.progress
        }
        levels[day.level!].days[day.id].current_repeat = day.current_repeat
        levels[day.level!].days[day.id].current_exercise = day.current_exercise

        var totalProgress: Float = 0
        for index in 0..<levels[day.level!].days.count {
            totalProgress += levels[day.level!].days[index].star! > 0 ? 1 : levels[day.level!].days[index].progress!
        }
        levels[day.level!].progress! = totalProgress / Float(levels[day.level!].days.count)
        if (day.progress! >= 1) {
            levels[day.level!].last_day! = day.id + 1
            if (levels[day.level!].last_day! >= levels[day.level!].days.count) {
                levels[day.level!].last_day! = 0
            }
        } else {
            levels[day.level!].last_day! = day.id
        }
        
        saveLevelData()
        
        _history.append(Exercised(id: _history.count, level: day.level!, day: day.id, date: Date(), duration: duration))
        saveHistoryData()
    }
    
    func initProgress() {
        for level in 0..<femaleLevels.count {
            femaleLevels[level].progress = 0
            femaleLevels[level].last_day = 0
            for day in 0..<femaleLevels[level].days.count {
                femaleLevels[level].days[day].progress = 0
                femaleLevels[level].days[day].current_exercise = 0
                femaleLevels[level].days[day].current_repeat = 0
                femaleLevels[level].days[day].star = 0
                femaleLevels[level].days[day].level = level
            }
        }
        for level in 0..<maleLevels.count {
            maleLevels[level].progress = 0
            maleLevels[level].last_day = 0
            for day in 0..<maleLevels[level].days.count {
                maleLevels[level].days[day].progress = 0
                maleLevels[level].days[day].current_exercise = 0
                maleLevels[level].days[day].current_repeat = 0
                maleLevels[level].days[day].star = 0
                maleLevels[level].days[day].level = level
            }
        }
    }
    
    func resetProgress() {
        initProgress()
        _levels = userSettings.gender == true ? maleLevels : femaleLevels
        saveLevelData()
        _history = []
        saveHistoryData()
    }
    
    func loadHistoryData() {
        guard let data = try? Data(contentsOf: historyFileURL) else {
            self._history = []
            return
        }
        guard let historyData = try? JSONDecoder().decode([Exercised].self, from: data) else {
            fatalError("Can't decode saved history data.")
        }
        self._history = historyData
    }
    
    func saveHistoryData() {
        guard let data = try? JSONEncoder().encode(history) else { fatalError("Error encoding data") }
        do {
            let outfile = historyFileURL
            try data.write(to: outfile)
        } catch {
            fatalError("Can't write to file")
        }
    }
    
    func getTotalDuration() -> Int {
        var totalDuration: Int = 0
        for exercised in _history {
            totalDuration += exercised.duration
        }
        return Int(Float(totalDuration) / 60)
    }
    
    func getTotalDays() -> Int {
        var totalDays: Int = 0
        var prevDay = 0
        var prevMonth = 0
        for exercised in _history {
            let components = exercised.date.get(.day, .month, .year)
            if (components.day != prevDay || components.month != prevMonth) {
                totalDays += 1
            }
            prevDay = components.day!
            prevMonth = components.month!
        }
        return totalDays
    }
    
    func getDurationHistory() -> [(String, Int)] {
        var durationHistory: [(String, Int)] = []
        let orderedHistory: [Int: [Int: [Exercised]]] = getKeyedHistory()
        for diff in 0...10 {
            let date = Calendar.current.date(byAdding: .day, value: -diff, to: Date())!
            let day = date.get(.day).day!
            let month = date.get(.month).month!
            var duration = 0
            if (orderedHistory[month] != nil && orderedHistory[month]?[day] != nil) {
                for exercised in orderedHistory[month]![day]! {
                    duration += exercised.duration
                }
                duration += 60
            }
            durationHistory.append((String(day), Int(Double(duration) / 60)))
        }
        return durationHistory.reversed()
    }
    
    func getKeyedHistory() -> [Int: [Int: [Exercised]]] {
        var orderedHistory: [Int: [Int: [Exercised]]] = [:]
        for exercised in _history.reversed() {
            let month = exercised.getMonth()
            if (orderedHistory[month] == nil) {
                orderedHistory[month] = [Int: [Exercised]]()
            }
            let day = exercised.getDay()
            if (orderedHistory[month]?[day] == nil) {
                orderedHistory[month]?[day] = [Exercised]()
            }
            orderedHistory[month]?[day]?.append(exercised)
        }
        return orderedHistory
    }
    
    func getOrderedHistory() -> [MonthHistory] {
        let orderedHistory: [Int: [Int: [Exercised]]] = getKeyedHistory()
        var convertedHistory: [MonthHistory] = []
        
        let months = orderedHistory.keys.sorted().reversed()
        for month in months {
            let monthData = orderedHistory[month]!
            var dayHistory: [DayHistory] = []
            let days = monthData.keys.sorted().reversed()
            for day in days {
                let dayData = monthData[day]!
                dayHistory.append(DayHistory(id: day, dayTitle: String(day), history: dayData))
            }
            convertedHistory.append(MonthHistory(id: month, monthTitle: DateFormatter().monthSymbols[month - 1], days: dayHistory))
        }
        return convertedHistory
    }
    
    init() {
        initProgress()
    }
    
    var lastDay: Int {
        return 0
    }
    
    var lastLevel: Int {
        for level in levels.reversed() {
            if (level.progress! > 0) {
                return level.id
            }
        }
        return 0
    }
    
    var selectedTheme: ThemeData {
        switch (userSettings.themeColor) {
        case "Blue":
            return theme[0]
        case "Purple":
            return theme[1]
        case "Green":
            return theme[2]
        case "Pink":
            return theme[3]
        default:
            return theme[3]
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
