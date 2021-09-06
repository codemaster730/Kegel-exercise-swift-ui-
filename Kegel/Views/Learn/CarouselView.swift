//
//  CarouselView.swift
//  Kegel
//
//  Created by Slav on 08.02.2021.
//

import SwiftUI

struct CarouselView: View {
    
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var modelData: ModelData
    @State var showNav: [Bool] = [false, false, false, false, false, false, false, false]
        
    var body: some View
    {
        let spacing:            CGFloat = 16
        let widthOfHiddenCards: CGFloat = 15    // UIScreen.main.bounds.width - 10
        let cardHeight:         CGFloat = UIScreen.main.bounds.size.height/1.8
        let cardLength:         Int     = 3

        return  Canvas
            {
                //
                // TODO: find a way to avoid passing same arguments to Carousel and Item
                //
                Carousel( numberOfItems: CGFloat( cardLength), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
                {
                    Item( _id:                  Int(0),
                          spacing:              spacing,
                          widthOfHiddenCards:   widthOfHiddenCards,
                          cardHeight:           cardHeight )
                    {
                        VStack(alignment: .leading){
                            
                            VStack{
                                HStack(alignment: .bottom){
                                    Text("01")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("whats_kegel")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 40)
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[0] = true
                            }
                            NavigationLink(destination: WhatsKegelView(), isActive: $showNav[0]) {
                                EmptyView()
                            }
                            
                            VStack{
                                HStack(alignment: .bottom){
                                    Text("02")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("what_are_the_benefits")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[1] = true
                            }
                            NavigationLink(destination: WhatBenefitsView(), isActive: $showNav[1]) {
                                EmptyView()
                            }
                            
                            VStack{
                                HStack(alignment: .bottom){
                                    Text("03")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("can_i_do_kegel")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[2] = true
                            }
                            NavigationLink(destination: CanKegelView(), isActive: $showNav[2]) {
                                EmptyView()
                            }
                            
                            if(modelData.userSettings.gender){
                                Spacer()
                            }else{
                                VStack{
                                    HStack(alignment: .bottom){
                                        Text("04")
                                            .foregroundColor(Color.white.opacity(0.5))
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                            
                                        Text("|")
                                            .foregroundColor(Color.white.opacity(0.5))
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        Text("who_is_not_suitable")
                                            .foregroundColor(.white)
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 15, height: 20)
                                            .foregroundColor(Color.white.opacity(0.5))
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    }
                                    .padding(.leading, 20)
                                    .padding(.top, 20)
                                    .padding(.bottom, 15)
                                    .padding(.trailing, 20)
                                    
                                    Rectangle()
                                        .padding(.leading, 60)
                                        .padding(.trailing, 20)
                                        .frame(height: 0.3, alignment: .center)
                                        .foregroundColor(Color.white)
                                }
                                .onTapGesture {
                                    showNav[3] = true
                                }
                                NavigationLink(destination: WhosNotSuitableView(), isActive: $showNav[3]) {
                                    EmptyView()
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .foregroundColor( Color.red )
                    .background(
                        Image(modelData.selectedTheme.learnCardColors.card1)
                            .resizable()
                    )
                    .cornerRadius( 8 )
                    .transition( AnyTransition.slide )
                    .animation( .spring() )
                    
                    Item( _id:                  Int(1),
                          spacing:              spacing,
                          widthOfHiddenCards:   widthOfHiddenCards,
                          cardHeight:           cardHeight )
                    {
                        
                        VStack(alignment: .leading){
                            VStack{
                                HStack(alignment: .top){
                                    Text("01")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("how_to_do_kegel")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 40)
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[4] = true
                            }
                            NavigationLink(destination: HowKegelView(), isActive: $showNav[4]) {
                                EmptyView()
                            }
                            
                            VStack{
                                HStack(alignment: .top){
                                    Text("02")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("how_to_find_pelvic")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[5] = true
                            }
                            NavigationLink(destination: HowPelvicView(), isActive: $showNav[5]) {
                                EmptyView()
                            }
                            VStack{
                                HStack(alignment: .top){
                                    Text("03")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("please_note")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[6] = true
                            }
                            NavigationLink(destination: PleaseNoteView(), isActive: $showNav[6]) {
                                EmptyView()
                            }
                            VStack{
                                HStack(alignment: .bottom){
                                    Text("04")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                        
                                    Text("|")
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Text("disclaimer")
                                        .foregroundColor(.white)
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 15, height: 20)
                                        .foregroundColor(Color.white.opacity(0.5))
                                        .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowTitle.fontSize)))
                                }
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)
                                
                                Rectangle()
                                    .padding(.leading, 60)
                                    .padding(.trailing, 20)
                                    .frame(height: 0.3, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                showNav[7] = true
                            }
                            NavigationLink(destination: DisclaimerView(), isActive: $showNav[7]) {
                                EmptyView()
                            }
                            
                            Spacer()
                        }
                    }
                    .foregroundColor( Color.red )
                    .background(
                        Image(modelData.selectedTheme.learnCardColors.card2)
                            .resizable()
                    )
                    .cornerRadius( 8 )
                    .transition( AnyTransition.slide )
                    .animation( .spring() )
                    
                    Item( _id:                  Int(2),
                          spacing:              spacing,
                          widthOfHiddenCards:   widthOfHiddenCards,
                          cardHeight:           cardHeight )
                    {
                        VStack(alignment: .center){
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.3))
                                    .frame(width: 60, height: 60)
                                
                                if(modelData.userSettings.gender){
                                    Image("female")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
//                                        .rotationEffect(Angle(degrees:134))
                                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }else{
                                    Image("male")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                        .rotationEffect(Angle(degrees:134))
                                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                                
                                    
                            }
                            .padding(.top, 50)
                            
                            Text(modelData.userSettings.gender ? "BENEFITS_FOR_WOMEN" : "BENEFITS_FOR_MEN")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.dayTitle.fontSize)))
                                .padding(.leading, 30)
                                .padding(.trailing, 30)
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            Button(action: {
                                print("sign up bin tapped")
                            }) {
                                NavigationLink(destination: BenefitsView()) {
                                    HStack{
                                        Text("learn")
                                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.subTitle.fontSize)))
                                                  
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.white)
                                            
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(hexString: modelData.selectedTheme.primaryColor, alpha: 1), Color(hexString: modelData.selectedTheme.primaryColor, alpha: 0.8)]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius( 30 )
                                }
                                
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.bottom, 40)
                            
                            
                            
                        }
                    }
                    .foregroundColor( Color.red )
                    .background(
                        Image(modelData.selectedTheme.learnCardColors.card3)
                            .resizable()
                    )
                    .cornerRadius( 8 )
                    .transition( AnyTransition.slide )
                    .animation( .spring() )
                    
                }
                .environmentObject(UIState)
            }
    }
}

struct Card: Decodable, Hashable, Identifiable
{
    var id:     Int
    var name:   String = ""
}

public class UIStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing

        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)

        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)

        }.onEnded { value in
            self.UIState.screenDrag = 0

            if (value.translation.width < -50) {
                
                if(self.UIState.activeCard < Int(numberOfItems - 1)){
                    self.UIState.activeCard = self.UIState.activeCard + 1
                }
                
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }

            if (value.translation.width > 50) {
                if(self.UIState.activeCard > 0) {
                    self.UIState.activeCard = self.UIState.activeCard - 1
                }
            
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color(hexString: ModelData().selectedTheme.backgroundColor))
    }
}

struct Item<Content: View>: View {
    
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }

    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}


struct CarouselView_Previews: PreviewProvider {
    
    static var previews: some View {
        CarouselView()
            .environmentObject(UIStateModel())
            .environmentObject(ModelData())
    }
}
