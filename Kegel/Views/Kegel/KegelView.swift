//
//  KegelView.swift
//  Kegel
//
//  Created by A on 04.02.2021.
//

import SwiftUI

struct KegelView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var currentLevel = 0
    @State private var selectedLevel = 0
    @State var progressValue: Float = 0.3
    @State private var isLoaded = false
    @Binding var rootIsActive: [Bool]
    
    var body: some View {
        
        ZStack {
            Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea()
            
            VStack(spacing: 10) {
                HStack {
                    Text("kegel")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        .padding(.leading, 20)
                    Spacer()
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(modelData.levels) { level in
                                ZStack {
                                    VStack(alignment: .leading) {
                                        Image(level.id == 0 ? "progressbar_left" : level.id == modelData.levels.count - 1 ? "progressbar_right" : "progressbar2")
                                            .renderingMode(.template)
                                            .foregroundColor(Color(hexString: modelData.selectedTheme.secondColor, alpha: level.id <= currentLevel ? 1 : 0.3))
                                        Image(level.id == selectedLevel ? "bg_level_select_\(modelData.selectedTheme.name)" : "bg_level")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .edgesIgnoringSafeArea(.all)
                                            .padding(.leading, 10)
                                            .padding(.trailing, 10)
                                    }
                                    .frame(width:118)
                                    if (level.id == selectedLevel) {
                                        CircleProgressBar(progress: modelData.levels[level.id].progress!)
                                            .frame(width: 60, height: 60)
                                            .padding(.top, 34)
                                    } else {
                                        VStack {
                                            Text("level \(level.id + 1)")
                                                .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.3))
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                            Text("\(Int(modelData.levels[level.id].progress! * 100))%")
                                                .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.3))
                                                .font(.system(size: 22))
                                                .fontWeight(.bold)
                                                .padding(.top, 1)
                                        }
                                        .padding(.top, 35)
                                    }
                                }
                                .onTapGesture {
                                    selectedLevel = level.id
                                    withAnimation(.linear(duration: 30)) {
                                        scrollView.scrollTo(selectedLevel, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                }

                HStack {
                    Text("level \(selectedLevel + 1)").font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 15)

                ScrollView{
                    VStack {
                        ForEach(modelData.levels[selectedLevel].days) { day in
                            NavigationLink(destination: DayDetailView(day: day, selectedLevel: $selectedLevel, rootIsActive: $rootIsActive), isActive: $rootIsActive[day.id]) {
                                DayView(day: day, selectedLevel: $selectedLevel).environmentObject(modelData)
                            }
                            .isDetailLink(false)
                            .buttonStyle(FlatLinkStyle())
                        }
                    }
                }
                .animation(.easeIn(duration: 0.1))
                .transition(.move(edge: .bottom))
                .id("Level \(selectedLevel)")
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = UIColor(Color(hexString: modelData.selectedTheme.backgroundColor))
            if (!isLoaded) {
                isLoaded = true
                currentLevel = modelData.lastLevel
                selectedLevel = currentLevel
            }
        }
    }
}

struct KegelView_Previews: PreviewProvider {
    @State static var rootIsActive: [Bool] = [false, false, false, false, false]
    static var previews: some View {
        KegelView(rootIsActive: $rootIsActive).environmentObject(ModelData())
    }
}
