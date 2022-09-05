//
//  ProductModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 02.09.2022.
//

import SwiftUI

// MARK: - Product
struct Product: Codable {
    let cpu, camera: String
    private let capacity: [String]
    let colorHex: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd, ssd, title: String
    
    var imagesURLs: [URL] {
        images.compactMap { URL(string: $0) }
    }
    
    var colors: [ColorIdentifiable] {
        var uniqueId = 0
        var colors = [ColorIdentifiable]()
        for hex in colorHex {
            colors.append(ColorIdentifiable(id: uniqueId, color: Color(hex: hex)))
            uniqueId += 1
        }
        return colors
    }
    
    var capacities: [CapacityIdentifiable] {
        var uniqueId = 0
        var capacities = [CapacityIdentifiable]()
        for value in capacity {
            capacities.append(CapacityIdentifiable(id: uniqueId, value: value))
            uniqueId += 1
        }
        return capacities
    }
    
    struct ColorIdentifiable: Identifiable, Equatable {
        let id: Int
        let color: Color
    }
    
    struct CapacityIdentifiable: Identifiable, Equatable {
        let id: Int
        let value: String
    }
    
    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case colorHex = "color"
        case camera, capacity, id, images, isFavorites, price, rating, sd, ssd, title
    }
}
