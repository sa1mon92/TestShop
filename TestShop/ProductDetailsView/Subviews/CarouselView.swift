//
//  CarouselView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 04.09.2022.
//

import SwiftUI

struct CarouselView: View {
    
    let itemHeight: CGFloat
    let spacing: CGFloat = 30
    let views: [AnyView]
    
    @GestureState private var dragState = DragState.inacive
    @State var carouselLocation = 0
    
    private var viewsForPresentation: [AnyView] {
        if 2...3 ~= views.count {
            return views + views
        } else {
            return views
        }
    }
    
    private var relativeLocation: Int {
        ((viewsForPresentation.count * 10000) + carouselLocation) % viewsForPresentation.count
    }
    
    private var itemWidth: CGFloat {
        itemHeight * 0.8
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<viewsForPresentation.count, id: \.self) { i in
                Spacer()
                self.viewsForPresentation[i]
                    .frame(width: itemWidth, height: self.getHeight(i))
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: getShadow(i).color, radius: getShadow(i).radius, x: 0, y: getShadow(i).y)
                    .opacity(self.getOpacity(i))
                    .offset(x: self.getOffset(i))
                    .gesture(dragGesture)
                Spacer()
            }
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
            }
            .onEnded { value in
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 30, initialVelocity: 10)) {
                    onDragEnded(drag: value)
                }
            }
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold: CGFloat = 100
        if drag.predictedEndTranslation.width > dragThreshold ||
            drag.translation.width > dragThreshold {
            carouselLocation -= 1
        } else if drag.predictedEndTranslation.width < -dragThreshold ||
                    drag.translation.width < -dragThreshold {
            carouselLocation += 1
        }
    }
    
    private func getHeight(_ i: Int) -> CGFloat {
        if i == relativeLocation {
            return itemHeight
        } else {
            return itemHeight * 0.83
        }
    }

    private func getOpacity(_ i: Int) -> Double {
        if i == relativeLocation
            || i + 1 == relativeLocation
            || i - 1 == relativeLocation
            || (i + 1) - viewsForPresentation.count == relativeLocation
            || (i - 1) + viewsForPresentation.count == relativeLocation
        {
            return 1
        } else {
            return 0
        }
    }
    
    private func getOffset(_ i: Int) -> CGFloat {
        
        //This sets up the central offset
        if i == relativeLocation {
            //Set offset of central
            return self.dragState.translation.width
        }
        // These set up the offset +/- 1
        else if i == relativeLocation + 1 || (relativeLocation == viewsForPresentation.count - 1 && i == 0) {
            //Set offset +1
            return self.dragState.translation.width + (itemWidth + spacing)
        }
        else if i == relativeLocation - 1 || (relativeLocation == 0 && i == viewsForPresentation.count - 1) {
            //Set offset -1
            return self.dragState.translation.width - (itemWidth + spacing)
        }
        //These set up the offset +/- 2
        else if i == relativeLocation + 2
                    || (relativeLocation == viewsForPresentation.count - 1 && i == 1)
                    || (relativeLocation == viewsForPresentation.count - 2 && i == 0) {
            //Set offset +2
            return self.dragState.translation.width + (2 * (itemWidth + spacing))
        } else if i == relativeLocation + 2
                    || (relativeLocation == 1 && i == viewsForPresentation.count - 1)
                    || (relativeLocation == 0 && i == viewsForPresentation.count - 2) {
            //Set offset -2
            return self.dragState.translation.width - (2 * (itemWidth + spacing))
        }
        //These set up the offset +/- 3
        else if i == relativeLocation + 3
                    || (relativeLocation == viewsForPresentation.count - 1 && i == 2)
                    || (relativeLocation == viewsForPresentation.count - 2 && i == 1)
                    || (relativeLocation == viewsForPresentation.count - 3 && i == 0) {
            //Set offset +3
            return self.dragState.translation.width + (3 * (itemWidth + spacing))
        } else if i == relativeLocation - 3
                    || (relativeLocation == 2 && i == viewsForPresentation.count - 1)
                    || (relativeLocation == 1 && i == viewsForPresentation.count - 2)
                    || (relativeLocation == 0 && i == viewsForPresentation.count - 3) {
            //Set offset -3
            return self.dragState.translation.width - (3 * (itemWidth + spacing))
        }
        //This is remainder
        else {
            return 10000
        }
    }
    
    private func getShadow(_ i: Int) -> Shadow {
        let color = Constants.shadowColor
        //This sets up the central offset
        if i == relativeLocation {
            //Set offset of central
            return Shadow(color: color, radius: 20, x: 0, y: 10)
        }
        // These set up the offset +/- 1
        else if i == relativeLocation + 1 || (relativeLocation == viewsForPresentation.count - 1 && i == 0) {
            //Set offset +1
            return Shadow(color: color, radius: 10, x: 0, y: 5)
        }
        else if i == relativeLocation - 1 || (relativeLocation == 0 && i == viewsForPresentation.count - 1) {
            //Set offset -1
            return Shadow(color: color, radius: 10, x: 0, y: 5)
        }
        //This is remainder
        else {
            return Shadow(color: Color.clear, radius: 0, x: 0, y: 0)
        }
    }

    enum DragState {
        case inacive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inacive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inacive:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
}













//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}
