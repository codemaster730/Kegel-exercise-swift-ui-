//
//  WhatBenefitsView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct WhatBenefitsView: View {
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
                        
                        Text("what_are_the_benefits")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("sex_life")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                .fontWeight(.medium)
                            
                            VStack(alignment: .leading, spacing: 30){
                                if(modelData.userSettings.gender){
                                    Text("- Help with erectile dysfunction.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text("- Get more intense orgasms.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text("- Last longer in bed.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                        .multilineTextAlignment(.leading)
                                }else{
                                    Text("improve_blood_circulation_")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text("increase_sexual_arousal_")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                HStack {
                                    Spacer()
                                    Image("ic_tip_2")
                                        .resizable()
                                        .frame(width: 120, height: 100, alignment: .center)
                                    Spacer()
                                }
                            }
                             
                            
                        }
                        
                        if(modelData.userSettings.gender){
                            
                        }else{
                            VStack(alignment: .leading, spacing: 10){
                                Text("pregnancy")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    .fontWeight(.medium)
                                
                                
                                VStack(alignment: .leading, spacing: 30){
                                    
                                    Text("prevent_urinary_incon_")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                     
                                    
                                    Text("reduce_labor_pain_")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                    
                                    Text("speed_the_postpartum_")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                    
                                    HStack {
                                        Spacer()
                                        Image("ic_tip_3")
                                            .resizable()
                                            .frame(width: 130, height: 120, alignment: .center)
                                        Spacer()
                                    }
                                
                                }
                                 
                                
                            }
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("self_care")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                .fontWeight(.medium)
                            
                            
                            VStack(alignment: .leading, spacing: 30){
                                
                                if(modelData.userSettings.gender){
                                    Text("- Prevent and reduce prostatitis.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                    
                                    Text("- Reduce urinary urgency and frequency.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                    
                                    Text("- Improve the symptoms of post micturition dribble.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                    
                                    Text("- Improve bladder and bowel control.")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                }else{
                                    Text("it_can_prevent_")
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                        .lineSpacing(10.0)
                                }
                                
                                
                                HStack {
                                    Spacer()
                                    Image("ic_tip_5")
                                        .resizable()
                                        .frame(width: 120, height: 120, alignment: .center)
                                    Spacer()
                                }
                            
                            }
                             
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("privacy")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                .fontWeight(.medium)
                            
                            
                            VStack(alignment: .leading, spacing: 30){
                                
                                Text("you_can_do_it_")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                    .lineSpacing(10.0)
                                
                                HStack {
                                    Spacer()
                                    Image("ic_tip_4")
                                        .resizable()
                                        .frame(width: 120, height: 80, alignment: .center)
                                    Spacer()
                                }
                            
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

struct WhatBenefitsView_Previews: PreviewProvider {
    static var previews: some View {
        WhatBenefitsView()
            .environmentObject(ModelData())
    }
}
