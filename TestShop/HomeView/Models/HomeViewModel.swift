//
//  HomeViewModel.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 29.08.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    @Published private(set) var selectedCategoryIndex = 0
    @Published private(set) var model: HomeModel?
    
    let categories = [Category(name: "Phones"),
                              Category(name: "Computer"),
                              Category(name: "Health"),
                              Category(name: "Books")]
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        fetchModel()
            .receive(on: DispatchQueue.main)
            .assign(to: \.model, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private func fetchModel() -> AnyPublisher<HomeModel?, Never>{
        guard let url = URL(string: Constants.mainURLString) else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
        return NetworkManager.shared.request(type: HomeModel.self, from: url)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    func selectCategory(_ category: Category) {
        selectedCategoryIndex = category.id
    }
    
}
