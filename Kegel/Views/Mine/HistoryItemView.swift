//
//  HistoryItemView.swift
//  Kegel
//
//  Created by King Python on 2/10/21.
//

import SwiftUI
import Foundation


struct HistoryItemView: View {
    @EnvironmentObject var modelData: ModelData
    var monthHistory: MonthHistory

    var body: some View {
        VStack {
            HStack {
                Text(monthHistory.monthTitle)
                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                    .foregroundColor(Color.black.opacity(0.5))
                Spacer()
            }
            LazyVStack {
                ForEach (monthHistory.days) { dayHistory in
                    HStack(alignment: .top) {
                        Text(dayHistory.dayTitle)
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.navTitle.fontSize)))
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.top, 25)
                        LazyVStack {
                            ForEach (dayHistory.history) { exercised in
                                VStack (alignment: .leading){
                                    HStack {
                                        Text("level \(exercised.level + 1), day \(exercised.day + 1)")
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                            .foregroundColor(.black)
                                            .padding(.top, 15)
                                        
                                        Spacer()
                                        

                                        Text(exercised.getTime())
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                            .foregroundColor(Color.black.opacity(0.5))
                                            .padding(.top, 15)

                                    }
                                    Spacer()
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundColor(Color.black.opacity(0.5))
                                        Text(String(format: "%02d:%02d", Int(exercised.duration / 60), exercised.duration % 60))
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                            .foregroundColor(Color.black.opacity(0.5))
                                    }
                                    .padding(.bottom, 15)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct HistoryItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(ModelData().history) { history in
//            HistoryItemView(item: history, day: 3, is_showday: true)
//                .environmentObject(ModelData())
//
//        }
//    }
//}
