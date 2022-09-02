//
//  FilterView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 01.09.2022.
//

import SwiftUI

struct Brand: Identifiable {
    let id = UUID()
    let name: String
}

struct FilterView: View {
    let brandsArray = [Brand(name: "Apple"), Brand(name: "Samsung"), Brand(name: "Huawei"), Brand(name: "Sony"), Brand(name: "ZTE"), Brand(name: "Nokia"), Brand(name: "Honor"), Brand(name: "Xiaomi")]
    
    @Binding var isPresented: Bool
    
    @State var brandDropped = false
    @State var currentBrand: Brand?
    
    @State var priceDropped = false
    @State var priceRange: ClosedRange<Float> = 0...10000
    
    @State var sizeDropped = false
    @State var sizeRange: ClosedRange<Float> = 4.5...5.5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            header
            ScrollView {
                VStack(spacing: 17) {
                    brand
                    price
                    size
                }
            }
        }.padding(.top, 24)
    }
    
    // MARK: - Header
    var header: some View {
        HStack {
            Button {
                withAnimation {
                    isPresented = false
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 37, height: 37)
                        .foregroundColor(Constants.darkColor)
                    Image(systemName: "multiply").foregroundColor(.white)
                }
            }
            Spacer()
            Spacer()
            Text("Filter options")
                .font(.system(size: 18))
                .frame(alignment: .center)
            Spacer()
            Button {
                // done()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 86, height: 37)
                        .foregroundColor(Constants.orangeColor)
                    Text("Done")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                
            }
        }.padding(EdgeInsets(top: 0, leading: 44, bottom: 0, trailing: 20))
    }
    
    // MARK: - Brand
    var brand: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Brand")
                .font(.system(size: 18, weight: .medium))
            ZStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.lightGrayColor, lineWidth: 2)
                        .frame(height: 37)
                    HStack {
                        Text(currentBrand?.name ?? brandsArray[0].name)
                        Spacer()
                        Button {
                            withAnimation {
                                brandDropped.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                    }.padding()
                }.opacity(brandDropped ? 0 : 1)
                if brandDropped {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.lightGrayColor, lineWidth: 2)
                        .frame(height: 44 * 4/* CGFloat(brandsArray.count) */)
                        .overlay {
                            List {
                                ForEach(brandsArray) { brand in
                                    HStack {
                                        Text(brand.name)
                                        Spacer()
                                        Button {
                                            withAnimation {
                                                currentBrand = brand
                                                brandDropped.toggle()
                                            }
                                        } label: {
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                    }.listRowSeparator(.hidden)
                                }

                            }.padding(2)
                                .listStyle(.plain)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                }
            }
        }.padding(EdgeInsets(top: 0, leading: 46, bottom: 0, trailing: 31))
    }
    
    // MARK: - Price
    var price: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Price")
                .font(.system(size: 18, weight: .medium))
            ZStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.lightGrayColor, lineWidth: 2)
                        .frame(height: 37)
                    HStack {
                        Text("\(Int(priceRange.lowerBound))$ - \(Int(priceRange.upperBound))$" )
                        Spacer()
                        Button {
                            withAnimation {
                                priceDropped.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                    }.padding()
                }.opacity(priceDropped ? 0 : 1)
                if priceDropped {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.lightGrayColor, lineWidth: 2)
                        .frame(height: 80)
                        .overlay {
                            VStack(alignment: .trailing, spacing: 0) {
                                Button {
                                    withAnimation {
                                        priceDropped.toggle()
                                    }
                                } label: {
                                    Image(systemName: "chevron.up")
                                        .foregroundColor(.gray)
                                }.padding(.horizontal)
                                HStack {
                                    Text("Min").font(.system(size: 16))
                                    RangedSliderView(value: $priceRange, bounds: 0...10000, unit: .dollar).padding(.horizontal, 5)
                                    Text("Max").font(.system(size: 16))
                                }
                                .frame(height: 40)
                                .padding(.horizontal)
                            }
                        }
                }
            }
        }.padding(EdgeInsets(top: 0, leading: 46, bottom: 0, trailing: 31))
    }
    
    // MARK: - Size
    var size: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Size")
                .font(.system(size: 18, weight: .medium))
            ZStack(alignment: .top) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.lightGrayColor, lineWidth: 2)
                        .frame(height: 37)
                    HStack {
                        Text("\(String(format: "%.1f", sizeRange.lowerBound)) to \(String(format: "%.1f", sizeRange.upperBound)) inches" )
                        Spacer()
                        Button {
                            withAnimation {
                                sizeDropped.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                    }.padding()
                }.opacity(sizeDropped ? 0 : 1)
                if sizeDropped {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Constants.lightGrayColor, lineWidth: 2)
                        .frame(height: 80)
                        .overlay {
                            VStack(alignment: .trailing, spacing: 0) {
                                Button {
                                    withAnimation {
                                        sizeDropped.toggle()
                                    }
                                } label: {
                                    Image(systemName: "chevron.up")
                                        .foregroundColor(.gray)
                                }.padding(.horizontal)
                                HStack {
                                    Text("Min").font(.system(size: 16))
                                    RangedSliderView(value: $sizeRange, bounds: 0...10, unit: .inch).padding(.horizontal, 5)
                                    Text("Max").font(.system(size: 16))
                                }
                                .frame(height: 40)
                                .padding(.horizontal)
                            }
                        }
                }
            }
        }.padding(EdgeInsets(top: 0, leading: 46, bottom: 0, trailing: 31))
    }
}

//struct FilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterView()
//    }
//}
