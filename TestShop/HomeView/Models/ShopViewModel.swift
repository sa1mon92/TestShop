//
//  HomeViewModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 29.08.2022.
//

import SwiftUI
import Combine

class ShopViewModel: ObservableObject {

    @Published private(set) var selectedCategoryIndex = 0
    @Published private(set) var homeModel: HomeModel?
    @Published private(set) var productDetailModel: Product?
    @Published private(set) var cart = [String: Int]()
    
    let categories = [Category(name: "Phones"),
                              Category(name: "Computer"),
                              Category(name: "Health"),
                              Category(name: "Books")]
    private var cancellableSet: Set<AnyCancellable> = []
    
    var cartCount: Int {
        return cart.values.map { Int($0) }.reduce(0, { x, y in x + y })
    }
    
    init() {
        NetworkDataFetcher.shared.fetch(from: Constants.mainURLString)
            .receive(on: DispatchQueue.main)
            .assign(to: \.homeModel, on: self)
            .store(in: &self.cancellableSet)
    }
    
    func getProduct(id: String) {
        /*fetch product url code*/
        productDetailModel = nil
        NetworkDataFetcher.shared.fetch(from: Constants.productURLString)
            .receive(on: DispatchQueue.main)
            .assign(to: \.productDetailModel, on: self)
            .store(in: &self.cancellableSet)
    }
    
    func selectCategory(_ category: Category) {
        selectedCategoryIndex = category.id
    }
    
    func addToCart(_ product: Product) {
        if cart.contains(where: { (key, value) in key == product.id }) {
            cart[product.id]! += 1
        } else {
            cart[product.id] = 1
        }
    }
    
    func removeOneFromCart(_ product: Product) {
        if var cartProduct = cart.first(where: { (key, value) in key == product.id }) {
            if cartProduct.value > 1 {
                cartProduct.value -= 1
            } else {
                cart.removeValue(forKey: cartProduct.key)
            }
        }
    }
    
    func removeAllFromCart(_ product: Product) {
        if let cartProduct = cart.first(where: { (key, value) in key == product.id }) {
            cart.removeValue(forKey: cartProduct.key)
        }
    }
}
