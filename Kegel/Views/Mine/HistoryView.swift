//
//  History.swift
//  Kegel
//
//  Created by King Python on 2/9/21.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    var showFromBeginning: Bool
    var selectedMonth: Int
    var selectedDay: Int
    
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
                        .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                    }
                    Text("history")
                        .font(.title2)
                        .fontWeight(.none)
                        .foregroundColor(Color.black.opacity(1))
                        .padding([.top, .bottom, .trailing], 10.0)
                }
                .padding(.leading, 20)
                
                ScrollViewReader { scrollView in
                    ScrollView {
                        LazyVStack {
                            ForEach (modelData.getOrderedHistory()) { history in
                                HistoryItemView(monthHistory: history)
                            }
                        }
                        .padding(20)
                    }
                    .onAppear() {
                        if (!showFromBeginning) {
                            scrollView.scrollTo(selectedDay, anchor: .top)
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(showFromBeginning: false, selectedMonth: 2, selectedDay: 16)
                .environmentObject(ModelData())
    }
}

