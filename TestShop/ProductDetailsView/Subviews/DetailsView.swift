//
//  DetailsView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 02.09.2022.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    
    let sections = [Section(id: 0, name: "Shop"), Section(id: 1, name: "Details"), Section(id: 2, name: "Features")]
    let geometry: GeometryProxy
    
    @State private var selectedSectionId = 0
    @State private var selectedColorId = 0
    @State private var selectedCapacityId = 0

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(viewModel.model?.title ?? "")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Constants.darkColor)
                    Spacer()
                    Button {
                        //
                    } label: {
                        if let isFavorites = viewModel.model?.isFavorites {
                            Image(isFavorites ? "FillFavourites" : "Favourites")
                                .frame(width: 37, height: 37)
                                .foregroundColor(.white)
                                .background(Constants.darkColor)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                HStack {
                    MyCosmosView(rating: viewModel.model?.rating ?? 0)
                }
            }
            
            HStack {
                ForEach(sections) { section in
                    let isSelected = section.id == selectedSectionId
                    Spacer()
                    VStack(spacing: 8) {
                        Text(section.name)
                            .font(.system(size: 20, weight: isSelected ? .bold : .regular))
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundColor(Constants.orangeColor)
                            .frame(height: 3)
                            .opacity(isSelected ? 1 : 0)
                    }
                    .frame(width: 90)
                    .onTapGesture {
                        selectedSectionId = section.id
                    }
                    Spacer()
                }
            }
            
            HStack {
                let itemWidth = (geometry.size.width - 70) / 4
                VStack {
                    Image("Processor")
                    Text(viewModel.model?.cpu ?? "")
                        .font(.system(size: 11))
                        .foregroundColor(Constants.grayColor)
                }.frame(width: itemWidth)
                Spacer()
                VStack {
                    Image("Camera")
                    Text(viewModel.model?.camera ?? "")
                        .font(.system(size: 11))
                        .foregroundColor(Constants.grayColor)
                }.frame(width: itemWidth)
                Spacer()
                VStack {
                    Image("Memory")
                    Text(viewModel.model?.ssd ?? "")
                        .font(.system(size: 11))
                        .foregroundColor(Constants.grayColor)
                }.frame(width: itemWidth)
                Spacer()
                VStack {
                    Image("Card")
                    Text(viewModel.model?.sd ?? "")
                        .font(.system(size: 11))
                        .foregroundColor(Constants.grayColor)
                }.frame(width: itemWidth)
            }
            
            VStack(alignment: .leading, spacing: 14) {
                Text("Select color and capacity")
                    .font(.system(size: 16, weight: .medium))
                HStack {
                    HStack(spacing: 18) {
                        if let colors = viewModel.model?.colors {
                            ForEach(colors) { color in
                                Circle()
                                    .frame(width: 39, height: 39)
                                    .foregroundColor(color.color)
                                    .overlay {
                                        if color.id == selectedColorId {
                                            Image("Checkmark")
                                        }
                                    }
                                    .onTapGesture {
                                        selectedColorId = color.id
                                    }
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        if let capacities = viewModel.model?.capacities {
                            ForEach(capacities) { capacitiy in
                                let isChoosen = capacitiy.id == selectedCapacityId
                                ZStack {
                                    if isChoosen {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Constants.orangeColor)
                                    }
                                    Text(capacitiy.value + " GB")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(isChoosen ? .white : .gray)
                                }
                                .frame(width: 70, height: 30)
                                .onTapGesture {
                                    selectedCapacityId = capacitiy.id
                                }
                            }
                        }
                    }
                }
            }
            
            Button {
                // Add to Cart()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Constants.orangeColor)
                    HStack {
                        Text("Add to Cart")
                        Spacer()
                        if let price = viewModel.model?.price {
                            Text("$\(price).00")
                        }
                        
                    }
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 40)
                }
            }.frame(width: geometry.size.width - 60, height: 52)
        }.padding(.horizontal, 30)
    }
    
    struct Section: Identifiable {
        let id: Int
        let name: String
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
