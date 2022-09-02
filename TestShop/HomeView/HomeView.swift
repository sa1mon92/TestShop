//
//  HomeView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 29.08.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    @State var filterIsPresented = true
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        selectCategory
                        search
                        hotSales
                        BestSellersView(geomerty: geometry)
                        Rectangle()
                            .foregroundColor(Constants.backgroundColor)
                            .frame(height: 80)
                    }.background(Constants.backgroundColor)
                }
                .overlay(alignment: .bottom, content: {
                    if !filterIsPresented {
                        TabView()
                            .transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                    }
                    if filterIsPresented {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(height: 420)
                            .foregroundColor(.white)
                            .transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                            .overlay {
                                FilterView(isPresented: $filterIsPresented)
                            }
                    }
                })
//                .adaptiveSheet(isPresented: $filterIsPresented, detents: [.medium()], smallestUndimmedDetentIdentifier: .large) {
//                    Text("TestSheet")
//                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("Location")
                                .foregroundColor(.red)
                            Text("Zihuatanejo, Gro")
                                .foregroundColor(Constants.darkColor)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                                .dynamicTypeSize(.xSmall)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                filterIsPresented.toggle()
                            }
                        } label: {
                            Image("Filter")
                                .resizable()
                                .frame(width: 11, height: 13)
                                .foregroundColor(Constants.darkColor)
                                .padding(.trailing, 25)
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - Select Category
    var selectCategory: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Select Category")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Constants.darkColor)
                    .padding(.leading, 17)
                Spacer()
                Button {
                    // viewAll()
                } label: {
                    Text("view all").font(.system(size: 15))
                        .foregroundColor(Constants.orangeColor)
                }
                .padding(.trailing, 40)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 23) {
                    ForEach(viewModel.categories) { category in
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(category.id == viewModel.selectedCategoryIndex ? Constants.orangeColor : .white)
                                    .frame(width: 71, height: 71)
                                Image(category.imageName)
                                    .renderingMode(.template)
                                    .foregroundColor(category.id == viewModel.selectedCategoryIndex ? .white : Constants.grayColor)
                            }
                            Text(category.name)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(category.id == viewModel.selectedCategoryIndex ? Constants.orangeColor : Constants.darkColor)
                        }
                        .onTapGesture {
                            viewModel.selectCategory(category)
                        }
                    }
                }.padding(.leading, 27)
            }
        }.padding(.top, 18)
    }
    
    // MARK: - Search
    @State private var searchText = ""
    
    var search: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 34)
                    .foregroundColor(.white)
                HStack {
                    Image("Search")
                        .renderingMode(.template)
                        .foregroundColor(Constants.orangeColor)
                    TextField("Search", text: $searchText)
                        .onChange(of: searchText) { text in
                            //model.search(text)
                        }
                }
                .padding(.leading, 24)
            }.padding(.leading, 32)
            ZStack {
                Circle()
                    .frame(width: 34, height: 34)
                    .foregroundColor(Constants.orangeColor)
                Image("QRcode")
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                //model.tapQRButton()
            }
            .padding(.trailing, 37)
        }.padding(.top, 35)
    }
    
    // MARK: - Hot Sales
    var hotSales: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Hot Sales")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
