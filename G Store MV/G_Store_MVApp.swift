//
//  G_Store_MVApp.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

@main
struct G_Store_MVApp: App {
    private var apiService = APIService()
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(ProductModel(apiService: apiService))
        }
    }
}
