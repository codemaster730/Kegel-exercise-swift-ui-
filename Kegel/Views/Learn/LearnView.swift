//
//  LearnView.swift
//  Kegel
//
//  Created by A on 04.02.2021.
//

import SwiftUI

struct LearnView: View {
    
//    @State private var selectedTab = 0
    
    @StateObject private var state: UIStateModel = UIStateModel()
    
    @EnvironmentObject var modelData: ModelData
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollViewReader { scrollView in
                VStack {
                    HStack{
                        Text("learn")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                            .padding(.leading, 20)
                        Spacer()
                    }
                
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{     
                                Text("about_kegel")
                                    .font(.system(size: CGFloat(ModelData().selectedTheme.textTheme.subTitle.fontSize)))
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: state.activeCard == 0 ? 1 : 0.3))
                                    .padding(.leading, 20)
                                    .onTapGesture{
                                        state.activeCard = 0
                                        withAnimation(.linear(duration: 30)) {
                                            scrollView.scrollTo("Tab1", anchor: .leading)
                                        }
                                    }
                                    .id("Tab1")
                                Text("how_to_do")
                                    .font(.system(size: CGFloat(ModelData().selectedTheme.textTheme.subTitle.fontSize)))
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: state.activeCard == 1 ? 1 : 0.3))
                                    .padding(.leading, 20)
                                    .onTapGesture{
                                        state.activeCard = 1
                                        withAnimation(.linear(duration: 30)) {
                                            scrollView.scrollTo("Tab2", anchor: .center)
                                        }
                                    }
                                    .id("Tab2")
                                
                            Text(modelData.userSettings.gender ? "benefits_for_women" : "benefits_for_men")
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: state.activeCard == 2 ? 1 : 0.3))
                                    .font(.system(size: CGFloat(ModelData().selectedTheme.textTheme.subTitle.fontSize)))
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .onTapGesture{
                                        state.activeCard = 2
                                        withAnimation(.linear(duration: 30)) {
                                            scrollView.scrollTo("Tab3", anchor: .trailing)
                                        }
                                    }
                                    .id("Tab3")
                        }
                        
                    }
                
                }
                
                
                CarouselView()
                    .environmentObject(modelData)
                    .environmentObject(state)
                    .onChange(of: state.activeCard) { _ in
                        withAnimation(.linear(duration: 30)) {
                            scrollView.scrollTo("Tab\(state.activeCard + 1)", anchor: .trailing)
                        }
                    }
                
                HStack{
                    ForEach((0..<3 ), id: \.self) {
                        DotIndicator(pageIndex: $0, isOn: state.activeCard)
                            .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: state.activeCard == $0 ? 1 : 0.3))
                        .frame(
                            width: 8,
                            height: 8
                        )
                    }
                }
                Spacer()
            }
        }.background(Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
    }
}

struct DotIndicator: View {
    let pageIndex: Int
    var isOn: Int
    var body: some View {
        if(pageIndex == isOn){
            Capsule()
                .frame(width: 12, height: 5)
                .scaleEffect(1.3)
                .animation(.spring())
        }else{
            Circle()
                .scaleEffect(0.9)
                .animation(.spring())
        }
        
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
            .environmentObject(ModelData())
            .environmentObject(UIStateModel())
    }
}
