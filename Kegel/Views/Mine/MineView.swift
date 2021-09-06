//
//  MineView.swift
//  Kegel
//
//  Created by A on 04.02.2021.
//

import SwiftUI

struct MineView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.calendar) var calendar

    @State var currentDate: Date = Date()
    @State var currentInterval: DateInterval = DateInterval()
    @State var isPrevNext = false
    @State var showHistory = false
    @State var showHistoryBeginning = true
    @State var selectedMonth: Int = 0
    @State var selectedDay: Int = 0
    
    func currentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
    func getMonthString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        if (formatter.string(from: Date()) == formatter.string(from: date)) {
            formatter.dateFormat = "MMMM"
        } else {
            formatter.dateFormat = "MMMM, yyyy"
        }
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func getWeeks(date: Date) -> Int {
        return Calendar.current.range(of: .weekOfYear, in: .month, for: date)!.count
    }

    var body: some View {
        ZStack {
            Color(hexString: modelData.selectedTheme.backgroundColor).ignoresSafeArea()
            
            
            VStack {
                HStack {
                    Text("mine")
                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))
                        .padding(.leading, 20)
                    Spacer()
                }
                
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading) {
                            Text("training")
                                .fontWeight(.bold)
                                .font(.title2)

                            HStack {
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                        .frame(height: nil)

                                    VStack(alignment: .leading) {
                                        Text("total")
                                        Text("duration")
                                        HStack {
                                            Text("\(modelData.getTotalDuration())")
                                                .font(.title)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            Text("min")
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                }
                                
                                Spacer(minLength: 15)
                                
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .foregroundColor(Color(hexString: modelData.selectedTheme.secondColor))
                                        .frame(height: nil)

                                    VStack(alignment: .leading) {
                                        Text("total")
                                        Text("days")
                                        HStack {
                                            Text("\(modelData.getTotalDays())")
                                                .font(.title)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            Text("days")
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                }
                            }
                        }
                        .padding(20)
                        
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                        ZStack(alignment: .top) {
                            HStack {
                                Text("Duration")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                Spacer()
                            }
                            .padding(.top, 20)
                            .padding(.leading, 20)
                            
                            LineView(data: ChartData(values: modelData.getDurationHistory()),
                                     style: ChartStyle(
                                        backgroundColor: Color.white,
                                        accentColor: Color(hexString: modelData.selectedTheme.primaryColor),
                                        secondGradientColor: Color(hexString: modelData.selectedTheme.primaryColor),
                                        textColor: Color.black,
                                        legendTextColor: Color.gray,
                                        dropShadowColor: Color.gray),
                                     valueSpecifier: "%.0fm")
                                .padding()
                                .padding(.top, 20)
                        }
                    }
                    .frame(height: 350)
                    
                    ZStack (alignment: .top){
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .frame(height: getWeeks(date: currentDate) == 5 ? 480 : 530)
                        
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("calendar")
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .padding(.bottom, 2)
                                    Text(currentDateString())
                                        .font(.system(size: 18))
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                            }
                            .padding(20)
                            
                            HStack {
                                Button(action: {
                                    withAnimation() {
                                        isPrevNext = true
                                        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                                        currentInterval = calendar.dateInterval(of: .month, for: currentDate)!
                                    }
                                }) {
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .frame(width: 20, height: 15)
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Text(getMonthString(date: currentDate))
                                    .font(.title2)
                                    .padding()
                                Spacer()
                                Button(action: {
                                    withAnimation() {
                                        isPrevNext = false
                                        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
                                        currentInterval = calendar.dateInterval(of: .month, for: currentDate)!
                                    }
                                }) {
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .frame(width: 20, height: 15)
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            HStack {
                                Group {
                                    Spacer()
                                    Text("S").foregroundColor(Color.gray)
                                }
                                Group {
                                    Spacer()
                                    Text("M").foregroundColor(Color.gray)
                                }
                                Group {
                                    Spacer()
                                    Text("T").foregroundColor(Color.gray)
                                }
                                Group {
                                    Spacer()
                                    Text("W").foregroundColor(Color.gray)
                                }
                                Group {
                                    Spacer()
                                    Text("T").foregroundColor(Color.gray)
                                }
                                Group {
                                    Spacer()
                                    Text("F").foregroundColor(Color.gray)
                                }
                                Group {
                                    Spacer()
                                    Text("S").foregroundColor(Color.gray)
                                }
                                Spacer()
                            }

                            CalendarView(interval: currentInterval, showHeaders: false) { date in
                                let day = self.calendar.component(.day, from: date)
                                let month = self.calendar.component(.month, from: date)
                                let history = modelData.getKeyedHistory()
                                let exerciseCount = (history[month] != nil && history[month]?[day] != nil) ? history[month]![day]!.count : 0
                                Button(action: {
                                    if (exerciseCount > 0) {
                                        selectedMonth = month
                                        selectedDay = day
                                        showHistoryBeginning = false
                                        showHistory = true
                                    }
                                }) {
                                    Text(String(day))
                                        .foregroundColor(.black)
                                        .frame(width: 37, height: 37)
                                        .background(
                                            TriCircleView(lineWidth: 3, color: Color(hexString: modelData.selectedTheme.primaryColor), progress: exerciseCount)
                                        )
                                }
                                .padding(4)
                            }
                            .transition(isPrevNext == true ? .moveAndFadeTrailingToLeading : .moveAndFadeLeadingToTrailing)
                            .animation(.easeInOut(duration: 0.3))
                            .id(currentDate)
                            .padding(.horizontal, 20)
                        }
                    }
                    Button(action: {
                        showHistory = true
                        showHistoryBeginning = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                        
                            HStack {
                                Text("history")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                    .foregroundColor(Color.black)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 9, height: 15)
                                    .foregroundColor(Color.black.opacity(0.3))
                                    .padding(.horizontal, 10)
                            }
                            .padding(20)
                        }
                    }
                    NavigationLink(destination: HistoryView(showFromBeginning: showHistoryBeginning, selectedMonth: selectedMonth, selectedDay: selectedDay), isActive: $showHistory){
                        EmptyView()
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear() {
            currentInterval = calendar.dateInterval(of: .month, for: currentDate)!
        }
    }
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView().environmentObject(ModelData())
    }
}

