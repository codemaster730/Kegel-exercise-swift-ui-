//
//  Theme.swift
//  Kegel
//
//  Created by A on 04.02.2021.
//

import Foundation
import SwiftUI

enum ThemeType {
    case pink
    case blue
    case purple
    case green
}

struct ThemeData: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var primaryColor: String
    var secondColor: String
    var backgroundColor: String
    var exerciseColor: String
    var repeatColor: String
    var textTheme: TextTheme
    var learnCardColors: LearnCardTheme
}

struct LearnCardTheme: Hashable, Codable{
    var card1: String
    var card2: String
    var card3: String
}

struct TextTheme: Hashable, Codable {
    var dayTitle: TextStyle
    var title: TextStyle
    var navTitle: TextStyle
    var subTitle: TextStyle
    var text: TextStyle
    var rowTitle: TextStyle
    var rowText: TextStyle
}

struct TextStyle: Hashable, Codable {
    var color: String
    var fontSize: Int
    var fontWeight: String
}
