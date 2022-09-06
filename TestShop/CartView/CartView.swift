//
//  CartView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 05.09.2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                header.padding(.top, 10)
                Spacer()
                Text("My Cart")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(Constants.darkColor)
                    .padding(.leading, 42)
                Spacer()
                cart
                    .frame(height: geometry.size.height - 150)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear {
                if let count = viewModel.cartModel?.products {
                    print(count)
                }
            }
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
            Text("Add address")
                .font(.system(size: 15))
                .foregroundColor(Constants.darkColor)
            Button {
                    //
            } label: {
                Image("Location")
                    .controlSize(.large)
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
                    .background(Constants.orangeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }.padding(EdgeInsets(top: 0, leading: 42, bottom: 0, trailing: 35))
    }
    
    var cart: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Constants.darkColor)
            VStack {
                ScrollView {
                    VStack(spacing: 45) {
                        if let products = viewModel.cartModel?.products {
                            ForEach(products) { product in
                               HStack {
                                   if let url = product.imageURL {
                                       AsyncImage(url: url) { image in
                                           image
                                               .resizable()
                                               .scaledToFit()
                                       } placeholder: {
                                           ProgressView()
                                       }
                                       .frame(width: 90, height: 90)
                                       .background(Color.white)
                                       .clipShape(RoundedRectangle(cornerRadius: 5))
                                   }
                                   VStack(alignment: .leading, spacing: 6) {
                                       Text(product.title)
                                           .foregroundColor(Color.white)
                                           .lineLimit(2)
                                       Text("$\(product.price).00")
                                           .foregroundColor(Constants.orangeColor)
                                   }
                                   .font(.system(size: 20, weight: .medium))
                                   .padding(.leading, 17)
                                   Spacer()
                                   ZStack {
                                       RoundedRectangle(cornerRadius: 26)
                                           .frame(width: 26, height: 68)
                                           .foregroundColor(Constants.stepperColor)
                                       VStack(spacing: 0) {
                                           Button {
                                               viewModel.removeProduct(product)
                                           } label: {
                                               Image("Minus")
                                                   .frame(width: 10, height: 10)
                                           }
                                           Spacer(minLength: 3)
                                           Text(String(viewModel.productsCounts[product.id] ?? 0))
                                               .font(.system(size: 20, weight: .medium))
                                           Spacer(minLength: 3)
                                           Button {
                                               viewModel.addProduct(product)
                                           } label: {
                                               Image("Plus")
                                                   .frame(width: 10, height: 10)
                                           }
                                       }
                                       .frame(width: 26, height: 50)
                                       .foregroundColor(.white)
                                   }
                                   Button {
                                       // remove()
                                   } label: {
                                       Image("Trash")
                                           .padding(.leading, 17)
                                   }
                               }.padding(.horizontal, 30)
                            }
                        }
                    }
                }.padding(.top, 80)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Constants.dividerColor)
                    .padding(.horizontal, 4)
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Total")
                        Text("Delivery")
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    Spacer()
                    VStack(alignment: .leading, spacing: 12) {
                        Text("$\(viewModel.cartModel?.total ?? 0) us")
                        Text("\(viewModel.cartModel?.delivery ?? "")")
                    }
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                }.padding(EdgeInsets(top: 15, leading: 55, bottom: 26, trailing: 35))
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Constants.dividerColor)
                    .padding(.horizontal, 4)
                Button {
                    //
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Constants.orangeColor)
                        Text("Checkout")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                }
                .frame(height: 54)
                .padding(EdgeInsets(top: 24, leading: 44, bottom: 44, trailing: 44))
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(CartViewModel())
    }
}
