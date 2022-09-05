//
//  HotSalesView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 02.09.2022.
//

import SwiftUI

struct HotSalesView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
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
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black)
                    .frame(height: 182)
                    .overlay(alignment: .trailing) {
                        if let url = viewModel.model?.homeStore[0].pictureURL {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 170, height: 170)
                            .background(Color.black)
                            .clipShape(Rectangle())
                            .padding(.trailing, 10)
                        }
                    }
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack {
                            Circle()
                                .frame(width: 27, height: 27)
                                .foregroundColor(Constants.orangeColor)
                            Text("New")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                        }.opacity(viewModel.model?.homeStore[0].isNew == true ? 1 : 0)
                        Text(viewModel.model?.homeStore[0].title ?? "")
                            .font(.system(size: 25, weight: .semibold)) // fix me
                            .foregroundColor(.white)
                            .padding(.top, 18)
                        Text(viewModel.model?.homeStore[0].subtitle ?? "")
                            .font(.system(size: 11, weight: .semibold)) // fix me
                            .foregroundColor(.white)
                            .padding(.top, 5)
                        Button {
                            // fix me
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                    .frame(width: 98, height: 23)
                                Text("Buy now!")
                                    .font(.system(size: 11, weight: .bold)) // fix me
                                    .foregroundColor(.black)
                            }
                        }.padding(.top, 26)
                    }
                    .padding(EdgeInsets(top: 14, leading: 25, bottom: 0, trailing: 0))
                }
            }.padding([.leading, .trailing], 15)
        }.padding(.top, 24)
    }
}

struct HotSalesView_Previews: PreviewProvider {
    static var previews: some View {
        HotSalesView()
            .environmentObject(HomeViewModel())
    }
}
