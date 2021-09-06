//
//  Level.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import Foundation

struct Exercised: Hashable, Codable, Identifiable {
    var id: Int
    var level: Int
    var day: Int
    var date: Date
    var duration: Int
    
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")

        return formatter.string(from: self.date)
    }
    
    func getDay() -> Int {
        return date.get(.day, .month, .year).day!
    }
    
    func getMonth() -> Int {
        return date.get(.day, .month, .year).month!
    }
}

struct MonthHistory: Hashable, Codable, Identifiable {
    var id: Int
    var monthTitle: String
    var days: [DayHistory]
}

struct DayHistory: Hashable, Codable, Identifiable {
    var id: Int
    var dayTitle: String
    var history: [Exercised]
}
