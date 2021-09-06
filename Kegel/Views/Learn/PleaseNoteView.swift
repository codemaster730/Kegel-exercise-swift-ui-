//
//  PleaseNoteView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct PleaseNoteView: View {
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
                        
                        Text("please_note")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        
                        VStack(alignment: .leading, spacing: 30){
                            Text("empty_your_bladder_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)

                        }

                        VStack(alignment: .leading, spacing: 30){
                            Text("perseverance_is_important_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)

                        }

                        VStack(alignment: .leading, spacing: 30){
                            Text("to_maximize_results_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)

                        }

                        VStack(alignment: .leading, spacing: 30){
                            Text("relax_your_body_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)

                        }
                                                
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack{
                                Text("got_it")
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

struct PleaseNoteView_Previews: PreviewProvider {
    static var previews: some View {
        PleaseNoteView()
            .environmentObject(ModelData())
    }
}
