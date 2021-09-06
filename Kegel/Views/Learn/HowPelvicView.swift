//
//  HowPelvicView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct HowPelvicView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var modelData: ModelData
    @StateObject private var screenState: ScreenStateModel = ScreenStateModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
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
                .foregroundColor(Color.black.opacity(0.5))
                .padding(.leading, 20)
                
                PelvicCarouselView()
                    .environmentObject(modelData)
                    .environmentObject(screenState)
                    
                
                VStack {
                    HStack{
                        if(modelData.userSettings.gender){
                            ForEach((0..<2 ), id: \.self) {
                                DotIndicator(pageIndex: $0, isOn: screenState.activeCard)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: screenState.activeCard == $0 ? 1 : 0.3))
                                .frame(
                                    width: 8,
                                    height: 8
                                )
                            }
                        }else{
                            ForEach((0..<3 ), id: \.self) {
                                DotIndicator(pageIndex: $0, isOn: screenState.activeCard)
                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor, alpha: screenState.activeCard == $0 ? 1 : 0.3))
                                .frame(
                                    width: 8,
                                    height: 8
                                )
                            }
                        }
                        
                    }
                    Spacer()
                        .frame(height: 40)
                    
                    Button(action: {
                        if(!modelData.userSettings.gender){
                            if(screenState.activeCard == 0 || screenState.activeCard == 1){
                                screenState.activeCard = screenState.activeCard + 1
                            }else{
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }else{
                            if(screenState.activeCard == 0){
                                screenState.activeCard = screenState.activeCard + 1
                            }else{
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }) {
                        HStack{
                            if(modelData.userSettings.gender){
                                Text(screenState.activeCard == 0 ? "next" : "got_it")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                    .multilineTextAlignment(.center)
                            }else{
                                Text(screenState.activeCard == 0||screenState.activeCard == 1 ? "next" : "got_it")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                    .multilineTextAlignment(.center)
                            }
                            
                                
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(hexString: "fe9882"))
                        .background(Color(hexString: "fe9882").opacity(0.1))
                        .cornerRadius( 30 )
                    }
                    .buttonStyle(FlatLinkStyle())
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
                
                
                Spacer()
                    .frame(height: 170)
            }

        }
        
        .background(Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
    }
}


struct HowPelvicView_Previews: PreviewProvider {
    static var previews: some View {
        HowPelvicView()
            .environmentObject(ModelData())
            .environmentObject(ScreenStateModel())
    }
}
