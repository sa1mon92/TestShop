//
//  ProductView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 02.09.2022.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                header
                    .padding(.vertical)
                Spacer()
                if let imagesURLs = viewModel.model?.imagesURLs {
                    let itemHeight = geometry.size.height - 440 - 50
                    CarouselView(itemHeight: itemHeight, views: imagesURLs.compactMap({ url in
                        AnyView(AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }.padding(30))
                    }))
                }
                Spacer(minLength: 14)
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 440)
                    .foregroundColor(.white)
                    .shadow(color: Constants.shadowColor, radius: 20, x: 0, y: -5)
                    .overlay {
                        DetailsView(geometry: geometry)
                    }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    var header: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
                    .background(Constants.darkColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
            Text("Product Details")
                .font(.system(size: 18))
                .foregroundColor(Constants.darkColor)
            Spacer()
            Button {
                //
            } label: {
                Image("Cart")
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
                    .background(Constants.orangeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }.padding(EdgeInsets(top: 0, leading: 42, bottom: 0, trailing: 35))
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
            .environmentObject(ProductViewModel())
    }
}
