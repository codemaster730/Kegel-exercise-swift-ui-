//
//  HowKegelView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct HowKegelView: View {
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
                        
                        Text("how_to_do_kegel")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        
                        VStack(alignment: .leading, spacing: 30){
                            Text("kegel_requires_a_rhythmic_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Spacer()
                                Image(modelData.userSettings.gender ? "ic_tip_61" : "ic_tip_62")
                                    .resizable()
                                    .frame(width: 220, height: 200, alignment: .center)
                                Spacer()
                            }
                             
                            
                        }
                                                
                        NavigationLink(destination: HowPelvicView()) {
                            HStack{
                                Text("how_to_find_pelvic")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                    .multilineTextAlignment(.center)
                                    
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

struct HowKegelView_Previews: PreviewProvider {
    static var previews: some View {
        HowKegelView()
            .environmentObject(ModelData())
    }
}
