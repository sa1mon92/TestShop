//
//  StringExtension.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 30.08.2022.
//

import Foundation

extension String {
    func toURL() -> URL? {
        URL(string: self)
    }
}
