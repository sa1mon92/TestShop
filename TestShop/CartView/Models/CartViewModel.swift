//
//  CartViewModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 05.09.2022.
//

import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    @Published private(set) var cartModel: Cart? {
        didSet {
            if let products = cartModel?.products {
                let _ = products.map { productsCounts[$0.id] = 1 }
            }
        }
    }
    @Published private(set) var productsCounts = [Int: Int]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        NetworkDataFetcher.shared.fetch(from: Constants.cartURLString)
            .receive(on: DispatchQueue.main)
            .assign(to: \.cartModel, on: self)
            .store(in: &self.cancellableSet)
    }
    
    func addProduct(_ product: CartProduct) {
        if productsCounts.contains(where: { (key, value) in key == product.id }) {
            productsCounts[product.id]! += 1
        } else {
            productsCounts[product.id] = 1
        }
    }
    
    func removeProduct(_ product: CartProduct) {
        if productsCounts.contains(where: { (key, value) in key == product.id }) {
            if productsCounts[product.id]! > 1 {
                productsCounts[product.id]! -= 1
            } else {
                productsCounts.removeValue(forKey: product.id)
            }
        }
    }
    
}
