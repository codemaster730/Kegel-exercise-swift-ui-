//
//  ContentView.swift
//  Kegel
//
//  Created by A on 04.02.2021.
//

import SwiftUI
import PartialSheet

enum Tab {
    case kegel
    case learn
    case mine
    case settings
}

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Tab = .kegel
    
}

struct ContentView: View {
    @State private var selection: Tab = .kegel
    @EnvironmentObject var modelData: ModelData
    @StateObject var viewRouter: ViewRouter
    @State var isActive: [Bool] = [false, false, false, false, false, false, false, false, false, false]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea()
                    VStack {
                        Spacer()
                        switch viewRouter.currentPage {
                            case .kegel:
                                KegelView(rootIsActive: $isActive)
                            case .learn:
                                LearnView()
                            case .mine:
                                MineView()
                            case .settings:
                                SettingsView()
                            }
                        Spacer()
                        ZStack {
                            HStack {
                                TabBarIcon(viewRouter: viewRouter, assignedPage: .kegel, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "heart.fill", tabName: "Kegel", selectedColor:Color(hexString: modelData.selectedTheme.primaryColor), unSelectedColor: Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.5))
                                TabBarIcon(viewRouter: viewRouter, assignedPage: .learn, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "book.fill", tabName: "Learn", selectedColor:Color(hexString: modelData.selectedTheme.primaryColor), unSelectedColor: Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.5))
                                TabBarIcon(viewRouter: viewRouter, assignedPage: .mine, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "person.fill", tabName: "Mine", selectedColor:Color(hexString: modelData.selectedTheme.primaryColor), unSelectedColor: Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.5))
                                TabBarIcon(viewRouter: viewRouter, assignedPage: .settings, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "gear", tabName: "Settings", selectedColor:Color(hexString: modelData.selectedTheme.primaryColor), unSelectedColor: Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.5))
                            }
                                .frame(width: geometry.size.width, height: geometry.size.height/8)
                            .background(Color(hexString: "fefefe"))
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .addPartialSheet(style: PartialSheetStyle.defaultStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environmentObject(ModelData())
    }
}

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Tab
    
    let width, height: CGFloat
    let systemIconName, tabName: String
    let selectedColor: Color
    let unSelectedColor: Color

    var body: some View {
        HStack {
            VStack {
                Image(systemName: systemIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                if (tabName == "Kegel") {
                    Text("kegel")
                        .font(.footnote)
                } else if (tabName == "Learn") {
                    Text("learn")
                        .font(.footnote)
                } else if (tabName == "Mine") {
                    Text("mine")
                        .font(.footnote)
                } else if (tabName == "Settings") {
                    Text("settings")
                        .font(.footnote)
                }
                Spacer()
            }
            .foregroundColor(viewRouter.currentPage == assignedPage ? selectedColor : unSelectedColor)
            .frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)
        }
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
    }
}
