//
//  Level.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import Foundation

struct Level: Hashable, Codable, Identifiable {
    var id: Int
    var progress: Float?
    var days: [Day]
    var last_day: Int?
}

struct Day: Hashable, Codable, Identifiable {
    var id: Int
    var progress: Float?
    var star: Int?
    var total_repeat_count: Int
    var duration: Int
    var current_exercise: Int?
    var current_repeat: Int?
    var exercises: [Exercise]
    var level: Int?
}

struct Exercise: Hashable, Codable, Identifiable {
    var id: Int
    var tense_time: Int
    var relax_time: Int
    var repeat_count: Int
}

