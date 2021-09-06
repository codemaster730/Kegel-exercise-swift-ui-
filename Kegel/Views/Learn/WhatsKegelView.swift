//
//  WhatsKegelView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct WhatsKegelView: View {
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
                        Text("whats_kegel")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        
                        VStack{
                            Text(modelData.userSettings.gender ? "Kegel is a form of exercise. It strengthens your pelvic floor muscles that support and control your bladder to prevent or control urinary incontinence." : "kegel_is_a_form_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                            
                            Spacer()
                                .frame(height:30)
                            
                            Text(modelData.userSettings.gender ? "Kegel exercises have proven to help men last longer in bed. They strengthen pelvic floor muscles(PC muscles) to help improve your sexual performance and bring you more intense orgasms." : "studies_show_that_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                            
                            Spacer()
                                .frame(height:80)
                            
                            NavigationLink(destination: WhatBenefitsView()) {
                                HStack{
                                    Text("what_are_the_benefits")
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
                                .frame(height:30)
                            
                            NavigationLink(destination: HowKegelView()) {
                                HStack{
                                    Text("how_to_do_kegel")
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
                                .frame(height:30)
                            
                            NavigationLink(destination: CanKegelView()) {
                                HStack{
                                    Text("can_i_do_kegel")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                        
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(Color(hexString: "fe9882"))
                                .background(Color(hexString: "fe9882").opacity(0.1))
                                .cornerRadius( 30 )
                            }
                            .buttonStyle(FlatLinkStyle())
                        }

                        
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

struct WhatsKegelView_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        WhatsKegelView()
            .environmentObject(modelData)
    }
}
