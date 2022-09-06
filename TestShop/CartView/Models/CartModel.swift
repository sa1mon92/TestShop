//
//  CartModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 05.09.2022.
//

import SwiftUI

// MARK: - Cart
struct Cart: Codable {
    let products: [CartProduct]
    let delivery, id: String
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case products = "basket"
        case delivery, id, total
    }
}

// MARK: - CartProduct
struct CartProduct: Codable, Identifiable {
    let id: Int
    let images: String
    let price: Int
    let title: String
    
    var imageURL: URL? {
        URL(string: images)
    }
}
