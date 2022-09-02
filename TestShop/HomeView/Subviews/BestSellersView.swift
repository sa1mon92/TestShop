//
//  BestSellersView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 31.08.2022.
//

import SwiftUI

struct BestSellersView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let geomerty: GeometryProxy
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Best Seller")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Constants.darkColor)
                    .padding(.leading, 17)
                Spacer()
                Button {
                    // viewAll()
                } label: {
                    Text("see more").font(.system(size: 15))
                        .foregroundColor(Constants.orangeColor)
                }
                .padding(.trailing, 40)
            }
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                if let bestSellers = viewModel.model?.bestSeller {
                    ForEach(bestSellers) { bestSeller in
                        BestSellerView(bestSeller: bestSeller, geometry: geomerty)
                    }
                }
            }.padding(EdgeInsets(top: 17, leading: 17, bottom: 0, trailing: 21))
        }.padding(.top, 20)
    }
}

struct BestSellerView: View {
    let bestSeller: BestSeller
    let geometry: GeometryProxy
    
    var itemWidth: CGFloat {
        geometry.size.width / 2 - 28
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: itemWidth)
                .aspectRatio(0.76, contentMode: .fill)
                .foregroundColor(.white)
                .overlay(alignment: .top) {
                    ZStack(alignment: .topTrailing) {
                        if let url = bestSeller.pictureURL {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(maxWidth: itemWidth, maxHeight: itemWidth)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                            Image(bestSeller.isFavorites ? "Like" : "Unlike")
                        }.padding(11)
                    }
                }
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .bottom) {
                    Text(String(bestSeller.discountPrice) + "$")
                        .font(.system(size: 16, weight: .bold))
                    Text(String(bestSeller.priceWithoutDiscount) + "$")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                }
                Text(bestSeller.title)
                    .font(.system(size: 10))
            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 0))
        }
    }
}

