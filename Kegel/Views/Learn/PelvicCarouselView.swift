//
//  PelvicCarouselView.swift
//  Kegel
//
//  Created by Slav on 16.02.2021.
//

import SwiftUI

struct PelvicCarouselView: View {
    
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var screenState: ScreenStateModel
    
    var body: some View {
        let spacing:            CGFloat =   16
        let widthOfHiddenCards: CGFloat = 0
        let cardHeight:         CGFloat = UIScreen.main.bounds.size.height/1.8
        let cardLength:         Int = modelData.userSettings.gender ? 2 : 3
        
        return Canvas
        {
            CarouselScreen(numberOfItems: CGFloat(cardLength), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards)
            {
                Order(_id: Int(0), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards, cardHeight: cardHeight)
                {
                    VStack(alignment: .leading, spacing: 40){
                    
                        Text("method 1")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))

                        VStack(alignment: .leading, spacing: 30){
                            Text("muscles_that_can_slow_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)

                            HStack {
                                Spacer()
                                Image("ic_tip_7")
                                    .resizable()
                                    .frame(width: 110, height: 110, alignment: .center)
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 50)
                    .padding(.top)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                }
                
                Order(_id: Int(1), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards, cardHeight: cardHeight)
                {
                    VStack(alignment: .leading, spacing: 40){
                        Text("method 2")
                            .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))

                        VStack(alignment: .leading, spacing: 30){
                            Text("muscles_that_can_prevent_")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                .lineSpacing(10.0)
                                .multilineTextAlignment(.leading)

                            HStack {
                                Spacer()
                                Image("ic_tip_8")
                                    .resizable()
                                    .frame(width: 110, height: 100, alignment: .center)
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.size.width -  50)
                    .padding(.top)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                }
                if(modelData.userSettings.gender){
                    
                }else{
                    Order(_id: Int(2), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards, cardHeight: cardHeight)
                    {
                        VStack(alignment: .leading, spacing: 40){
                        
                            Text("method 3")
                                .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.title.fontSize)))

                            VStack(alignment: .leading, spacing: 30){
                                Text("insert_a_finger_in_")
                                    .font(.system(size: CGFloat(modelData.selectedTheme.textTheme.rowText.fontSize)))
                                    .lineSpacing(10.0)
                                    .multilineTextAlignment(.leading)

                                HStack {
                                    Spacer()
                                    Image("ic_tip_9")
                                        .resizable()
                                        .frame(width: 90, height: 120, alignment: .center)
                                    Spacer()
                                }


                            }

                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.size.width -  50)
                        .padding(.top)
                        .padding(.leading, 25)
                        .padding(.trailing, 25)
                    }
                }
                
            }
        }
    }
}

public class ScreenStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
}

struct CarouselScreen<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var screenState: ScreenStateModel
        
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

        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(screenState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(screenState.activeCard) + 1)

        var calcOffset = Float(activeOffset)

        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + screenState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.screenState.screenDrag = Float(currentState.translation.width)

        }.onEnded { value in
            self.screenState.screenDrag = 0

            if (value.translation.width < -50) {
                
                if(self.screenState.activeCard < Int(numberOfItems - 1)){
                    self.screenState.activeCard = self.screenState.activeCard + 1
                }
                
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }

            if (value.translation.width > 50) {
                if(self.screenState.activeCard > 0) {
                    self.screenState.activeCard = self.screenState.activeCard - 1
                }
            
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

struct Order<Content: View>: View {
    
    @EnvironmentObject var screenState: ScreenStateModel
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
            .frame(width: cardWidth, height: _id == screenState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

struct PelvicCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PelvicCarouselView()
            .environmentObject(ModelData())
            .environmentObject(ScreenStateModel())
    }
}
