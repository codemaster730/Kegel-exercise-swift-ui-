//
//  WhosNotSuitableView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct WhosNotSuitableView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modelData: ModelData
    
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
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 40){
                        
                        Text("who_is_not_suitable")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        
                        VStack(alignment: .leading, spacing: 30){
                            Text("women_who_have_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Spacer()
                                Image("ic_tip_10")
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: .center)
                                Spacer()
                            }
                             
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 30){
                            Text("women_who_just_give_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Spacer()
                                Image("ic_tip_11")
                                    .resizable()
                                    .frame(width: 100, height: 90, alignment: .center)
                                Spacer()
                            }
                             
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 30){
                            Text("women_who_are_on_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Spacer()
                                Image("ic_tip_12")
                                    .resizable()
                                    .frame(width: 100, height: 90, alignment: .center)
                                Spacer()
                            }
                             
                            
                        }
                                                
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack{
                                Text("got_it")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                    
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color(hexString: "fe9882"))
                            .background(Color(hexString: "fe9882").opacity(0.1))
                            .cornerRadius( 30 )
                        }
                        .buttonStyle(FlatLinkStyle())
                        
                        Spacer()
                        
                    }
                    .padding(.top)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                }
                
                Spacer()
            }
            
            
        }
        
        .background(Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea())
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        
    }
}

struct WhosNotSuitableView_Previews: PreviewProvider {
    static var previews: some View {
        WhosNotSuitableView()
            .environmentObject(ModelData())
    }
}
