//
//  NotePopupView.swift
//  Kegel
//
//  Created by Slav on 10.02.2021.
//

import SwiftUI

struct NotePopupView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showModal: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("please_note")
                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 30) {
                Text("empty_your_bladder_")
                Text("relax_your_body_")
            }
            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.text.fontSize)))
            .lineSpacing(10.0)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color(hexString: modelData.selectedTheme.textTheme.text.color))

            Spacer()

            Button(action: {
                showModal = false
            }) {
                HStack{
                    Text("got_it")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color(hexString: "fe9882"))
                .background(Color(hexString: "fe9882").opacity(0.2))
                .cornerRadius( 30 )
            }
            .buttonStyle(FlatLinkStyle())
        }
        .padding(30)
    }
}

struct NotePopupViewPreviews: PreviewProvider {
    @State static var showModal = true
    static var previews: some View {
        NotePopupView(showModal: $showModal)
            .environmentObject(ModelData())
    }
}
