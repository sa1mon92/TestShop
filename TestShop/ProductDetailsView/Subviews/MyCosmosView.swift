//
//  MyCosmosView.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 03.09.2022.
//

import SwiftUI
import Cosmos

// A SwiftUI wrapper for Cosmos view
struct MyCosmosView: UIViewRepresentable {
    var rating: Double

    func makeUIView(context: Context) -> CosmosView {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.rating = rating
        view.settings.fillMode = .precise
        return view
    }

    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
    
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        // Change Cosmos view settings here
        uiView.settings.starSize = 18
    }
}
