//
//  TabView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 01.09.2022.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    @State var cartLinkActive = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 72)
                .foregroundColor(Constants.darkColor)
            HStack {
                HStack(spacing: 7) {
                    Image("Dot")
                    Text("Explorer")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                }
                Spacer()
                Button {
                    // open cart
                } label: {
                    ZStack {
                        let destinationLink = CartView().environmentObject(CartViewModel())
                        Image("Cart")
                            .background(NavigationLink("", destination: destinationLink, isActive: $cartLinkActive).opacity(0))
                            .onTapGesture {
                                cartLinkActive.toggle()
                            }
                        if viewModel.cartCount > 0 {
                            Text(String(viewModel.cartCount))
                                .frame(width: 20, height: 20)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .background(Constants.orangeColor)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .offset(x: 15, y: -10)
                        }
                    }
                }
                Spacer()
                Button {
                    // open favourites
                } label: {
                    Image("Favourites")
                }
                Spacer()
                Button {
                    // open user
                } label: {
                    Image("User")
                }
            }.padding([.leading, .trailing], 68)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
