//
//  NetworkManager.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 30.08.2022.
//

import SwiftUI
import Combine

enum APIError: Error, LocalizedError {
    case urlError(URLError)
    case responseError(Int)
    case decodingError(DecodingError)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .responseError(let status):
            return "Bad response code: \(status)"
        case .genericError:
            return "An unknown error has been occured"
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private var subscriptions = Set<AnyCancellable>()
    
    private init() { }
    
    func request<T: Codable>(type: T.Type, from url: URL) -> Future<T?, APIError> {
        return Future<T?, APIError> { [unowned self] promise in
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...300 ~= httpResponse.statusCode else {
                        throw APIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                    }
                    return data
                })
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as APIError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(.genericError))
                        }
                    }
                } receiveValue: { promise(.success($0)) }
                .store(in: &self.subscriptions)
        }
    }
    
}
