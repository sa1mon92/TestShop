//
//  TestShopApp.swift
//  TestShop
//
//  Created by Дмитрий Садырев on 29.08.2022.
//

import SwiftUI

@main
struct TestShopApp: App {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(viewModel)
//            FilterView().environmentObject(viewModel)
        }
    }
}
