//
//  NetworkDataFetcher.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 05.09.2022.
//

import SwiftUI
import Combine

class NetworkDataFetcher {
    static let shared = NetworkDataFetcher()
    
    private let networkManager = NetworkManager()
    private var subscriptions = Set<AnyCancellable>()
    
    private init() { }
    
    func fetch<T: Codable>(from urlString: String) -> AnyPublisher<T?, Never>{
        guard let url = URL(string: urlString) else {
            return Just(nil)
                .eraseToAnyPublisher()
        }
        return networkManager.request(type: T.self, from: url)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
