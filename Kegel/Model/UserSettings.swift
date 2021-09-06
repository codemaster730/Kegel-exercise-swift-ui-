//
//  UserSettings.swift
//  Kegel
//
//  Created by King Python on 2/9/21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var themeColor: String {
        didSet {
            UserDefaults.standard.set(themeColor, forKey: "themeColor")
        }
    }
    
    //Male: true, Female: false
    @Published var gender: Bool {
        didSet {
            UserDefaults.standard.set(gender, forKey: "gender")
        }
    }
    
    @Published var isReminder: Bool {
        didSet {
            UserDefaults.standard.set(isReminder, forKey: "isReminder")
        }
    }
    @Published var isVibration: Bool {
        didSet {
            UserDefaults.standard.set(isVibration, forKey: "isVibration")
        }
    }
    @Published var isVoice: Bool {
        didSet {
            UserDefaults.standard.set(isVoice, forKey: "isVoice")
        }
    }
    
    @Published var reminders: [String] {
        didSet {
            UserDefaults.standard.set(reminders, forKey: "reminders")
        }
    }
    
    @Published var selectedLanguage: String {
        didSet {
            UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
        }
    }
    
    init() {
        self.themeColor = UserDefaults.standard.object(forKey: "themeColor") as? String ?? "Pink"
        self.gender = UserDefaults.standard.object(forKey: "gender") as? Bool ?? true
        self.isReminder = UserDefaults.standard.object(forKey: "isReminder") as? Bool ?? false
        self.isVibration = UserDefaults.standard.object(forKey: "isVibration") as? Bool ?? false
        self.isVoice = UserDefaults.standard.object(forKey: "isVoice") as? Bool ?? false
        self.reminders = UserDefaults.standard.object(forKey: "reminders") as? [String] ?? []
        self.selectedLanguage = UserDefaults.standard.object(forKey: "selectedLanguage") as? String ?? Locale.current.languageCode!
    }
}
