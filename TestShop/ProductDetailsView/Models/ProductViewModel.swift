//
//  ProductDetailsViewModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 02.09.2022.
//

import SwiftUI
import Combine

class ProductViewModel: ObservableObject {
    
    @Published private(set) var model: Product?
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        fetchModel()
            .receive(on: DispatchQueue.main)
            .assign(to: \.model, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private func fetchModel() -> AnyPublisher<Product?, Never>{
        guard let url = URL(string: Constants.productURLString) else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
        return NetworkManager.shared.request(type: Product.self, from: url)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

