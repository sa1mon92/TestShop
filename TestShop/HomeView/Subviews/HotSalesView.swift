//
//  HotSalesView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 02.09.2022.
//

import SwiftUI

struct HotSalesView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                HStack {
                    Text("Hot Sales")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Constants.darkColor)
                        .padding(.leading, 17)
                    Spacer()
                    Button {
                        // seeMore()
                    } label: {
                        Text("see more").font(.system(size: 15))
                            .foregroundColor(Constants.orangeColor)
                    }
                    .padding(.trailing, 40)
                }
                
                Carousel(itemHeight: 182, itemWidth: geometry.size.width - 30, views: [
                    AnyView(
                        // First view begin
                        ZStack(alignment: .trailing) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                            if let url = viewModel.homeModel?.homeStore[0].pictureURL {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 175, height: 175)
                                .clipped()
                                .padding(.trailing, 5)
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("New")
                                        .frame(width: 27, height: 27)
                                        .font(.system(size: 10, weight: .bold))
                                        .background(Constants.orangeColor)
                                        .clipShape(Circle())
                                        .opacity(viewModel.homeModel?.homeStore[0].isNew ?? false ? 1 : 0)
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 9) {
                                        Text("\(viewModel.homeModel?.homeStore[0].title ?? "")")
                                            .font(.system(size: 25, weight: .bold))
                                        Text("\(viewModel.homeModel?.homeStore[0].subtitle ?? "")")
                                            .font(.system(size: 11))
                                    }
                                    Spacer()
                                    Button {
                                        //buyNow()
                                    } label: {
                                        Text("Buy now!")
                                            .frame(width: 98, height: 23)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }.opacity(viewModel.homeModel?.homeStore[0].isBuy ?? false ? 1 : 0)
                                }
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 14, leading: 25, bottom: 25, trailing: 0))
                                Spacer()
                            }
                        }
                        //First view end
                    ), AnyView(
                        //Second view begin
                        ZStack(alignment: .trailing) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                            if let url = viewModel.homeModel?.homeStore[1].pictureURL {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 182)
                                .clipped()
                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("New")
                                        .frame(width: 27, height: 27)
                                        .font(.system(size: 10, weight: .bold))
                                        .background(Constants.orangeColor)
                                        .clipShape(Circle())
                                        .opacity(viewModel.homeModel?.homeStore[1].isNew ?? false ? 1 : 0)
                                    Spacer()
                                    Button {
                                        //buyNow()
                                    } label: {
                                        Text("Buy now!")
                                            .frame(width: 98, height: 23)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }.opacity(viewModel.homeModel?.homeStore[1].isBuy ?? false ? 1 : 0)
                                }
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 14, leading: 25, bottom: 25, trailing: 0))
                                Spacer()
                            }
                        }
                        //Second view end
                    ), AnyView(
                        //Third view begin
                        ZStack(alignment: .trailing) {
                            let startColor = Color(.sRGB, red: 33 / 255, green: 33 / 255, blue: 33 / 255, opacity: 1)
                            let endColor = Color(.sRGB, red: 43 / 255, green: 43 / 255, blue: 43 / 255, opacity: 1)
                            LinearGradient(colors: [startColor, endColor], startPoint: .bottom, endPoint: .top)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            if let url = viewModel.homeModel?.homeStore[2].pictureURL {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 160, height: 182)
                                .offset(x: -80)
                                .clipped()                            }
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("New")
                                        .frame(width: 27, height: 27)
                                        .font(.system(size: 10, weight: .bold))
                                        .background(Constants.orangeColor)
                                        .clipShape(Circle())
                                        .opacity(viewModel.homeModel?.homeStore[2].isNew ?? false ? 1 : 0)
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 9) {
                                        Text("\(viewModel.homeModel?.homeStore[2].title ?? "")")
                                            .font(.system(size: 20, weight: .bold))
                                            .lineLimit(2)
                                        Text("\(viewModel.homeModel?.homeStore[2].subtitle ?? "")")
                                            .font(.system(size: 11))
                                    }
                                    Spacer()
                                    Button {
                                        //buyNow()
                                    } label: {
                                        Text("Buy now!")
                                            .frame(width: 98, height: 23)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }.opacity(viewModel.homeModel?.homeStore[2].isBuy ?? false ? 1 : 0)
                                }
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 14, leading: 25, bottom: 25, trailing: 0))
                                Spacer()
                            }
                        }
                        //Third view end
                    )
                ])
            }.padding(.top, 24)
        }
    }
}

struct Carousel: View {
    
    let itemHeight: CGFloat
    let itemWidth: CGFloat
    let spacing: CGFloat = 30
    let views: [AnyView]
    
    @GestureState private var dragState = DragState.inacive
    @State var carouselLocation = 0
    
    private var relativeLocation: Int {
        ((views.count * 10000) + carouselLocation) % views.count
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<views.count, id: \.self) { i in
                Spacer()
                self.views[i]
                    .frame(width: itemWidth, height: itemHeight)
                    .background(Color.white)
                    .cornerRadius(10)
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
    
    private func getOpacity(_ i: Int) -> Double {
        i == relativeLocation ? 1 : 0
    }
    
    private func getOffset(_ i: Int) -> CGFloat {
        if i == relativeLocation {
            return self.dragState.translation.width
        }
        else if i == relativeLocation + 1 || (relativeLocation == views.count - 1 && i == 0) {
            return self.dragState.translation.width + (itemWidth + spacing)
        }
        else if i == relativeLocation - 1 || (relativeLocation == 0 && i == views.count - 1) {
            return self.dragState.translation.width - (itemWidth + spacing)
        }
        else {
            return 10000
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


struct HotSalesView_Previews: PreviewProvider {
    static var previews: some View {
        HotSalesView()
            .environmentObject(ShopViewModel())
    }
}
