//
//  KegelApp.swift
//  Kegel
//
//  Created by A on 04.02.2021.
//

import SwiftUI
import PartialSheet

class NavigationHelper: ObservableObject {
    @Published var selection: String? = nil
}

@main
struct KegelApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject var viewRouter = ViewRouter()
    @StateObject var sheetManager: PartialSheetManager = PartialSheetManager()

    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .environmentObject(modelData)
                .environment(\.locale, Locale.init(identifier: modelData.userSettings.selectedLanguage))
                .environmentObject(NavigationHelper())
                .environmentObject(sheetManager)
                .onAppear() {
                    modelData.loadLevelData()
                }
        }
    }
}
