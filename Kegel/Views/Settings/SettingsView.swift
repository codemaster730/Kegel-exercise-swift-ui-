//
//  SettingsView.swift
//  kegel
//
//  Created by King Python on 2/4/21.
//
import SwiftUI
import Combine
import PartialSheet


let transparentTeal = Color(.sRGB, red: 0.4, green: 1, blue: 0.1, opacity: 0.2)

let red = Color.red

let transparentRed = Color(UIColor(red).withAlphaComponent(0.3))



//user
let backColor = Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255)
let fontGreyColor = Color(red: 155 / 255, green: 155 / 255, blue: 155 / 255)
let paddingSize = CGFloat(30)
let font1Size = CGFloat(28)
let font2Size = CGFloat(24)
let font3Size = CGFloat(20)
let themeColorString = "Pink"
let genderString = "Female"

let bold14 = Font.custom("TitilliumWeb-Bold", size: 14)
let bold16 = Font.custom("TitilliumWeb-Bold", size: 16)
let bold20 = Font.custom("TitilliumWeb-Bold", size: 20)
let primaryColor = Color(red: 1, green: 192/255, blue: 203/255)

struct SettingsView: View {
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @EnvironmentObject var modelData: ModelData
    
    @State private var showTimePickerModal = false
    @State private var showingResetAlert = false
    @State private var showLanguageOptionModal = false
    @State private var showGenderSelectModal = false
    @State private var showThemeSelectModal = false
    @State private var showRateModal = false
    @State var aTime = Date()
    @State var trick = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    Text("settings")
                        .padding()
                        .font(.system(size: font1Size, weight: .bold))
                    Spacer()
                }
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (alignment: .center) {
///-----------removeads-------
//                        VStack(alignment: .center,spacing: 5) {
//                            HStack{
//                                Text("remove_ads")
//                                    .font(.system(size: font2Size, weight: .bold))
//                                Spacer()
//                            }.padding()
//
//                            HStack (spacing: 5) {
//                                Text("upgrade_to_remove_ads")
//                                    .font(.system(size: font3Size))
//                                    .foregroundColor(fontGreyColor)
//                                    .padding()
//                                Spacer()
//                                Text("$2.99")
//                                    .foregroundColor(.white)
//                                    .font(.system(size:font2Size))
//                                    .background(
//                                        LinearGradient(
//                                            gradient: Gradient(
//                                                colors: [Color.red, Color.green]),
//                                                startPoint: .leading,
//                                                endPoint: .trailing
//                                        ).cornerRadius(10)
//                                        .frame(width: font2Size*4, height:font2Size*2)
//                                    )
//                                    .padding()
//                            }
//                            .padding()
//
//                            Button(action: {
//                                print("Rounded Button")
//                            }, label: {
//                                Text("why_I_see_ads")
//                                    .padding(.vertical,10)
//                                    .font(.system(size:font2Size))
//                                    .frame(width: geometry.size.width-paddingSize*3)
//                                    .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 20)
//                                            .stroke(lineWidth: 0)
//                                            .background(Color(hexString: modelData.selectedTheme.primaryColor).cornerRadius(20).opacity(0.2))
//                                    )
//                            })
//                            .padding()
//
//                        }
//                        .background(Color(red: 1, green: 1, blue: 1))
//                        .cornerRadius(15)
//                        .frame(width: geometry.size.width - paddingSize)
//
//                        HStack{
//                        }.padding(5)
//---------------------Reminders
                        VStack(alignment: .center,spacing: 0) {
                            HStack{
                                Text("reminders")
                                    .font(.system(size: font2Size, weight: .bold))
                                    .padding(.top, paddingSize)
                                Spacer()
                                Toggle(isOn: $modelData.userSettings.isReminder) {
                                }
                                .toggleStyle(CheckBoxStyle())
                            }.padding()
                            
                            Text("doing_kegel_3_times")
                                .font(.system(size: font3Size))
                                .foregroundColor(modelData.userSettings.isReminder ? fontGreyColor.opacity(0.3) : fontGreyColor)
                                .frame(width: geometry.size.width-paddingSize*3)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 0)
                                        .background(Color.gray.cornerRadius(10).opacity(0.1))
                                )
                                .lineLimit(nil)
                            
                            HStack{
                            }.padding()
                            
                            Text(trick).foregroundColor(Color.white.opacity(0)).hidden()
                            ForEach(modelData.userSettings.reminders , id: \.self) { reminderTime in
                                HStack{
                                    Image(systemName: "clock")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: font2Size+4, height: font2Size+4)
                                    Text(reminderTime)
                                        .font(.system(size: font2Size+2, weight: .bold))
                                        .foregroundColor(modelData.userSettings.isReminder ? fontGreyColor.opacity(0.3) : Color.black)
                                    Spacer()
                                    Button(action: {
                                        var remove_at = -1
                                        modelData.userSettings.reminders.enumerated().forEach( { (index,item) in
                                            if item==reminderTime {
                                                remove_at = index
                                            }
                                        })
                                        if(remove_at != -1){
                                            modelData.userSettings.reminders.remove(at: remove_at )
                                        }
                                        modelData.scheduleReminders()
                                        trick += " "
                                    }, label: {
                                        Image(systemName: "trash.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: font2Size, height: font2Size)
                                    })
                                }
                                .font(.system(size: font3Size,weight: .bold))
                                .foregroundColor(modelData.userSettings.isReminder ? fontGreyColor.opacity(0.3) : fontGreyColor)
                                .frame(width: geometry.size.width-paddingSize*3)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 0)
                                        .background(fontGreyColor.cornerRadius(10).opacity(0.1))
                                )
                            }
                            
                            HStack{
                            }.padding()
                            
                            Button(action: {
                                print("+Add Reminder")
                                self.showTimePickerModal.toggle()
                            }, label: {
                                Text("add_reminder")
                                    .padding(.vertical,10)
                                    .font(.system(size:font2Size))
                                    .frame(width: geometry.size.width/2)
                                    .foregroundColor(modelData.userSettings.isReminder ? fontGreyColor.opacity(0.3) : Color(hexString: modelData.selectedTheme.primaryColor))
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 0)
                                            .background(Color(hexString: modelData.selectedTheme.primaryColor).cornerRadius(20).opacity(0.2))
                                    )
                            })
                            .disabled(modelData.userSettings.isReminder)
                            .partialSheet(isPresented: $showTimePickerModal) {
                                TimeSelectModalView(showModal: self.$showTimePickerModal, times:$modelData.userSettings.reminders)
                                .frame(height: 200)
                            }
                            
                            HStack{
                            }.padding()
                            
                        }
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(15)
                        .frame(width: geometry.size.width - paddingSize)
                                   
                        HStack{
                        }.padding(5)
//--------reminder exit-------------
//--------SoundOptionsView---------------
                        VStack(alignment: .leading,spacing: 0) {
                            Text("sound_options")
                                .font(.system(size: font2Size, weight: .bold))
                                .padding()
                            HStack (spacing: 5) {
                                VStack(alignment: .center) {
                                    Image("vector_setting_vibration_"+modelData.userSettings.themeColor.lowercased())
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width:70, height:70)
                                        .padding()
                                    Text("vibration")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width:geometry.size.width/10*4)
                                    Toggle(isOn: $modelData.userSettings.isVibration) {
                                    }
                                    .toggleStyle(CheckBoxStyle())
                                    .padding()
                                }.background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 0)
                                        .background(Color.gray.cornerRadius(10).opacity(0.1))
                                )
                                Spacer()
                                VStack(alignment: .center) {
                                    Image("vector_setting_voice_"+modelData.userSettings.themeColor.lowercased())
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width:70, height:70)
                                        .padding()
                                    Text("voice_guide")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width:geometry.size.width/10*4)
                                    Toggle(isOn: $modelData.userSettings.isVoice) {
                                    }
                                    .toggleStyle(CheckBoxStyle())
                                    .padding()
                                }.background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 0)
                                        .background(Color.gray.cornerRadius(10).opacity(0.1))
                                )
                            }.frame(width: geometry.size.width-paddingSize*2)
                            .padding()
                        }
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(15)
                        .frame(width: geometry.size.width - paddingSize)
                        HStack{
                        }.padding(5)
//--------Sound exit---------------
//----------GeneralSettingsView------------
                        VStack(alignment: .center,spacing: 0) {
                            HStack{
                                Text("general_settings")
                                    .font(.system(size: font2Size, weight: .bold))
                                    .padding(.top, paddingSize)
                                Spacer()
                            }.padding()
                            
                            
                            Button(action: {
                                self.showThemeSelectModal.toggle()
                            }, label: {
                                HStack{
                                    Text("theme")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Rectangle()
                                        .foregroundColor(Color(hexString: modelData.selectedTheme.primaryColor))
                                        .frame(width: paddingSize, height: paddingSize, alignment: .center)
                                        .cornerRadius(5)
                                    Text(modelData.userSettings.themeColor)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: font3Size))
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                            .partialSheet(isPresented: $showThemeSelectModal) {
                                ThemeSelectModalView(showModal: self.$showThemeSelectModal, themeColor: $modelData.userSettings.themeColor)
                                    .frame(height: 400)
                            }


                            Button(action: {
                                self.showGenderSelectModal.toggle()
                            }, label: {
                                HStack{
                                    Text("gender")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Text((modelData.userSettings.gender ? "Male" : "Female"))
                                        .foregroundColor(Color.black)
                                        .font(.system(size: font3Size))
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                            .partialSheet(isPresented: $showGenderSelectModal) {
                                GenderSelectModalView(showModal: self.$showGenderSelectModal, gender: $modelData.userSettings.gender)
                                    .frame(height: 200)
                            }
                            
                            
                            Button(action: {
                                self.showLanguageOptionModal.toggle()
                            }, label: {
                                HStack{
                                    Text("language_options")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Text(modelData.userSettings.selectedLanguage)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: font3Size))
                                    
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                            .partialSheet(isPresented: $showLanguageOptionModal) {
                                LanguageOptionModalView(showModal: self.$showLanguageOptionModal, selLang: $modelData.userSettings.selectedLanguage)
                                    .frame(height: 200)
                            }
                            
                            
                            Button(action: {
                                self.showingResetAlert = true
                            }, label: {
                                HStack{
                                    Text("reset_progress")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                            .alert(isPresented: $showingResetAlert) {
                                Alert(
                                    title: Text("reset_progress"),
                                    message: Text(""),
                                    primaryButton: .default(
                                        Text("yes"),
                                        action: {
                                            modelData.resetProgress()
                                        }
                                    ),
                                    secondaryButton: .destructive(
                                        Text("no"),
                                        action: {
                                            print("no")
                                        }
                                    )
                                )
                            }
                        }
                        .frame(width: geometry.size.width - paddingSize)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(15)
                        
                        HStack{
                        }.padding(5)
//------------General exit---------------
//--------------ContactUsView----------
                        VStack(alignment: .center,spacing: 0) {
                            HStack{
                                Text("contact_us")
                                    .font(.system(size: font2Size, weight: .bold))
                                    .padding(.top, paddingSize)
                                Spacer()
                            }.padding()
                            
                            Button(action: {
                                print("Privacy policy")
                            }, label: {
                                HStack{
                                    Text("privacy_policy")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                            Button(action: {
                                showRateModal = true
                            }, label: {
                                HStack{
                                    Text("rate_us")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                            .partialSheet(isPresented: $showRateModal) {
                                Text("Send email to test@test.com")
                            }
                            Button(action: {
                                print("feedback")
                            }, label: {
                                HStack{
                                    Text("feedback")
                                        .font(.system(size: font3Size))
                                        .foregroundColor(Color.black)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 9, height: 15)
                                        .foregroundColor(Color.black.opacity(0.3))
                                        .padding(.horizontal, 10)
                                }
                            })
                        }
                        .frame(width: geometry.size.width - paddingSize)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .cornerRadius(15)
                        
                        HStack{
                        }.padding(5)
//-----------Contact exit----------------
                    }
                }
            }
        }.background(Color(hexString: modelData.selectedTheme.backgroundColor))
    }
}


//user struct
struct CheckBoxStyle: ToggleStyle {
    @EnvironmentObject var modelData: ModelData
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(configuration.isOn ? .gray : Color(hexString: modelData.selectedTheme.primaryColor))
                    .frame(width: 40, height: 20, alignment: .center)
                    .overlay(
                        Circle()
                            .strokeBorder(Color.black.opacity(0.2), lineWidth: 1)
                            .background(Circle().foregroundColor(.white))
                            .offset(x: configuration.isOn ? -10 : 10, y: 0)
                            .animation(Animation.linear(duration: 0.1))
                            
                    ).cornerRadius(20)
                    .onTapGesture { configuration.isOn.toggle() }
                configuration.label
                    .offset(x: configuration.isOn ? 7: -7)
            }
            
        }
 
    }
}

struct LanguageOptionModalView: View {
    @Binding var showModal: Bool
    @Binding var selLang: String
    var frameworks = ["English", "简体中文", "German", "French", "日本语"]
    var codes = ["en", "zh", "de", "fr", "ja"]
    @State private var selectedLanguageIndex = 0
    @State private var prevIndex = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedLanguageIndex, label: Text("language_options")) {
                ForEach(0 ..< frameworks.count) {
                    Text(self.frameworks[$0])
                }
            }
            .onAppear {
                codes.enumerated().forEach( { (index,item) in
                    if item==selLang {
                        selectedLanguageIndex = index
                        prevIndex = index
                    }
                })
            }
            
        }.onChange(of: selectedLanguageIndex) { _ in
            if (prevIndex != selectedLanguageIndex) {
                selLang = codes[selectedLanguageIndex]
//                self.showModal.toggle()
            }
        }
    }
}

struct GenderSelectModalView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showModal: Bool
    @Binding var gender: Bool
    
    var genders = ["male", "female"]
    @State private var selectedGenderIndex = 0
      
    var body: some View {
        VStack {
            Picker(selection: $selectedGenderIndex, label: Text("gender")) {
                ForEach(0 ..< genders.count) {
                    Text(self.genders[$0])
                }
            }.onAppear{
                selectedGenderIndex = (gender ? 0 : 1)
            }.onChange(of: selectedGenderIndex) { _ in
                gender = (selectedGenderIndex==0 ? true : false)
                modelData.loadLevelData()
                //self.showModal.toggle()
            }
        }
    }
}

struct TimeSelectModalView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showModal: Bool
    @Binding var times: [String]
    @State private var currentDate = Date()
    @State var timeFormatter = DateFormatter()
    
    @State var stringDate:String = ""
    
    var body: some View {
        VStack {
            DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
                // .onTapGesture {
                //     timeFormatter.dateFormat = "hh:mm a"
                //     stringDate = timeFormatter.string(from: currentDate)
                // }
            
            HStack{
                Button("OK") {
                    timeFormatter.dateFormat = "hh:mm a"
                    stringDate = timeFormatter.string(from: currentDate)
                    times.append(stringDate)
                    modelData.scheduleReminders()
                    self.showModal.toggle()
                }
                Spacer()
                Button("Cancel") {
                    self.showModal.toggle()
                }
            }.frame(width: 150, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}


struct ThemeSelectModalView: View {
    @Binding var showModal: Bool
    @Binding var themeColor: String

    var themes = ["Blue", "Purple", "Green", "Pink"]
    @State private var selectedThemeIndex = 1
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    selectedThemeIndex = 0
                    themeColor = "Blue"
                    print("Rounded Button")
                    self.showModal.toggle()
                }, label: {
                    VStack{
                        Image("bg_theme_blue")
                            .resizable()
                            .frame(width:100, height:100)
                            .padding()
                            .opacity((themeColor=="Blue") ? 1.0 : 0.3)
                        Text("Blue")
                    }
                })
                
                Button(action: {
                    selectedThemeIndex = 1
                    themeColor = "Purple"
                    print("Rounded Button")
                    self.showModal.toggle()
                }, label: {
                    VStack{
                        Image("bg_theme_purple")
                            .resizable()
                            .frame(width:100, height:100)
                            .padding()
                            .opacity((themeColor=="Purple") ? 1.0 : 0.3)
                        Text("Purple")
                    }
                })
            }
            HStack{
                Button(action: {
                    selectedThemeIndex = 2
                    themeColor = "Green"
                    print("Rounded Button")
                    self.showModal.toggle()
                }, label: {
                    VStack{
                        Image("bg_theme_green")
                            .resizable()
                            .frame(width:100, height:100)
                            .padding()
                            .opacity((themeColor=="Green") ? 1.0 : 0.3)
                        Text("Green")
                    }
                })
                
                Button(action: {
                    selectedThemeIndex = 3
                    themeColor = "Pink"
                    print("Rounded Button")
                    self.showModal.toggle()
                }, label: {
                    VStack{
                        Image("bg_theme_pink")
                            .resizable()
                            .frame(width:100, height:100)
                            .padding()
                            .opacity((themeColor=="Pink") ? 1.0 : 0.3)
                        Text("Pink")
                    }
                })
            }
        }.frame(height: 500)
    }
}


struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
            .addPartialSheet()
            .environmentObject(PartialSheetManager())
            .environment(\.locale, Locale.init(identifier: "zh-Hans"))
        //RemoveAdsView()
        // RemindersView()
        //     .addPartialSheet()
        //     .environmentObject(PartialSheetManager())
        //SoundOptionsView()
//        GeneralSettingsView()
//            .addPartialSheet()
//            .environmentObject(PartialSheetManager())
        //TimeSelectModalView(showModal: .constant(true))
        //ThemeSelectModalView(showModal: .constant(true))
        //LanguageOptionModalView(showModal: .constant(true))
          //  .environment(\.locale, Locale.init(identifier: "es"))
                    //ContactUsView()
    }
}
