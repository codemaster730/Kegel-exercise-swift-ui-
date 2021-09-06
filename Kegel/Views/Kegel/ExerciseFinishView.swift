//
//  DayDetailView.swift
//  Kegel
//
//  Created by A on 05.02.2021.
//

import SwiftUI

struct ExerciseFinishView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    @State var day: Day
    @State var isTinkle = false
    @Binding var shouldPopToRootView: Bool
    
    private let animation = Animation.easeInOut(duration: 3).repeatForever(autoreverses: true)
    private let animation2 = Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)
    
    var body: some View {
        ZStack {
            Color(hexString: modelData.selectedTheme.primaryColor).ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 10) {
                        ZStack {
                            HStack {
                                Button(action: {
                                    shouldPopToRootView = false
                                }) {
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .frame(width: 25, height: 20)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                        .resizable()
                                        .frame(width: 25, height: 28)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.horizontal, 20)
                        
                        Text("day \(day.id + 1)")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.dayTitle.fontSize)))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("completed \(day.star! < 3 ? day.star! + 1 : 3) time" + (day.star! == 0 ? "" : "s"))
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.navTitle.fontSize)))
                            .foregroundColor(.white)
                        
                        ZStack(alignment: .top) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white.opacity(0.8))
                                .offset(x: -120)
                                .opacity(isTinkle ? 1 : 0.3)
                                .onAppear() {
                                    withAnimation(self.animation, {
                                        self.isTinkle.toggle()
                                    })
                                }
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white.opacity(0.5))
                                .offset(x: 120, y: 50)
                                .opacity(isTinkle ? 1.5 : 0.1)
                                .onAppear() {
                                    withAnimation(self.animation2, {
                                        self.isTinkle.toggle()
                                    })
                                }
                            HStack {
                                Spacer()
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.yellow)
                                Spacer()
                                Image(systemName: (day.star! > 0 ? "star.fill" : "star"))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(day.star! > 0 ? .yellow : .white)
                                    .padding(.bottom, 60)
                                Spacer()
                                Image(systemName: (day.star! > 1 ? "star.fill" : "star"))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(day.star! > 1 ? .yellow : .white)
                                Spacer()
                            }
                            .padding(.horizontal, 40)
                        }
                        .padding(.top, 40)

                        ZStack(alignment: .top) {
                            Image(systemName: "lightbulb")
                                .resizable()
                                .frame(width: 15, height: 20)
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .trim(from: 0.5, to: 1)
                                        .fill(Color.white.opacity(0.15))
                                        .frame(width: 50, height: 50)
                                )
                            Text("doing_kegel_3_times")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.white.opacity(0.15))
                                )
                                .padding(.top, 10)
                        }
                        .padding(.horizontal, 20)
                        
                        Button(action: {
                            shouldPopToRootView = false
                        }) {
                            Spacer()
                            Text("continue")
                                .foregroundColor(.black)
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .foregroundColor(.white)
                                .frame(height: 60)
                        )
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Spacer()
                            Text("do_it_again")
                                .foregroundColor(.white)
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 20)
                        
                        VStack {
                            Text("how_do_you_feel")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                .fontWeight(.bold)
                            HStack {
                                VStack {
                                    Image(systemName: "smiley")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                    Text("hard")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "smiley")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                    Text("just_right")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "smiley")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                    Text("easy")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                            }
                            .padding(.horizontal, 50)
                            .padding(.top, 20)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(.white)
                                .frame(height: 200))
                        .padding(.horizontal, 20)
                        .padding(.top, 70)
                        .padding(.bottom, 30)
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct ExerciseFinishView_Previews: PreviewProvider {
    static let modelData = ModelData()
    @State static var shouldPopToRootView: Bool = false
    static var previews: some View {
        ExerciseFinishView(day: modelData.levels[0].days[0], shouldPopToRootView: $shouldPopToRootView).environmentObject(modelData)
    }
}
