//
//  HomeModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 29.08.2022.
//

import Foundation

// MARK: - Category
struct Category: Identifiable {
    
    private static var count: Int = 0
    
    let id: Int
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.id = Category.count
        self.name = name
        self.imageName = imageName
        Category.count += 1
    }
    
    init(name: String) {
        self.init(name: name, imageName: name)
    }
}

// MARK: - HomeModel
struct HomeModel: Codable {
    let homeStore: [HomeStore]
    let bestSeller: [BestSeller]

    enum CodingKeys: String, CodingKey {
        case homeStore = "home_store"
        case bestSeller = "best_seller"
    }
}

// MARK: - BestSeller
struct BestSeller: Codable, Identifiable {
    let id: Int
    let isFavorites: Bool
    let title: String
    let priceWithoutDiscount, discountPrice: Int
    let picture: String
    
    var pictureURL: URL? {
        URL(string: picture)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case isFavorites = "is_favorites"
        case title
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case picture
    }
}

// MARK: - HomeStore
struct HomeStore: Codable {
    let id: Int
    let isNew: Bool?
    let title, subtitle: String
    let picture: String
    let isBuy: Bool
    
    var pictureURL: URL? {
        URL(string: picture)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case isNew = "is_new"
        case title, subtitle, picture
        case isBuy = "is_buy"
    }
}
