//
//  TabView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 01.09.2022.
//

import SwiftUI

struct TabView: View {
    
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
                    Image("Cart")
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
