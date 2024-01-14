//
//  G_Store_MVApp.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

@main
struct G_Store_MVApp: App {
    @StateObject private var model : ProductModel
    
    init() {
        var conf = Configuration()
        let apiService = APIService(baseUrl: conf.environment.baseUrl)
       _model = StateObject(wrappedValue: ProductModel(apiService: apiService))
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(model)
        }
    }
}
