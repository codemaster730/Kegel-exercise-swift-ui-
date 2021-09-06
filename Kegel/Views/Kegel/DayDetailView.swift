//
//  DayDetailView.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import SwiftUI

struct DayDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    var day: Day
    @Binding var selectedLevel: Int
    @Binding var rootIsActive: [Bool]
    @State var startExercise = false
    @State var showStartAnimation = false
    
    var body: some View {
        ZStack {
            Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea()
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 25, height: 20)
                        }
                        Spacer()
                    }
                    Text("level \(selectedLevel + 1)")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.navTitle.fontSize)))
                        .fontWeight(.bold)
                }
                .foregroundColor(Color.black.opacity(0.5))
                .padding(.horizontal, 20)

                Text("day \(day.id + 1)")
                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.dayTitle.fontSize)))

                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(Color.black.opacity(0.5))
                    Text(String(format: "%02d:%02d", Int(day.duration / 60), day.duration % 60))
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                        .foregroundColor(Color.black.opacity(0.5))
                }
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40 )
                )
                .padding(.top, 20)
                
                HStack {
                    Text("exercises")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "square.on.square")
                        .foregroundColor(Color.black.opacity(0.5))
                    Text("\(day.total_repeat_count)")
                        .foregroundColor(Color.black.opacity(0.5))
                }
                .padding(20)
                
                ScrollView{
                    LazyVStack {
                        ForEach(day.exercises) { exercise in
                            ExerciseView(exercise: exercise).environmentObject(modelData)
                            .buttonStyle(FlatLinkStyle())
                        }
                    }
                }
                .animation(.easeIn(duration: 0.1))
                .transition(.move(edge: .bottom))
                .id("Level \(selectedLevel)")
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        showStartAnimation = true
                    }) {
                        Spacer()
                        Text("start")
                            .foregroundColor(.white)
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination: ExerciseDetailView(day: day, rootIsActive: $rootIsActive[day.id]), isActive: $startExercise) {
                            EmptyView()
                        }
                        .isDetailLink(false)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                            .frame(height: 60)
                    )
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .topLeading)
                .background(Color.white)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, -30)
            }
            
            if showStartAnimation {
                StartExerciseView(startExercise: $startExercise, showStartAnimation: $showStartAnimation)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct DayDetailView_Previews: PreviewProvider {
    static let modelData = ModelData()
    @State static var selectedLevel = 1
    @State static var rootIsActive = [false, false, false, false, false]
    static var previews: some View {
        DayDetailView(day: modelData.levels[0].days[0], selectedLevel: $selectedLevel, rootIsActive: $rootIsActive).environmentObject(modelData)
    }
}
