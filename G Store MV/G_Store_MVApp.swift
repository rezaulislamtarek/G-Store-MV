//
//  G_Store_MVApp.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

@main
struct G_Store_MVApp: App {
    @StateObject private var productModel : ProductModel
    @StateObject private var categoryModel : CagtegoryModel
    
    init() {
        var conf = Configuration()
        let apiService = APIService(baseUrl: conf.environment.baseUrl)
       _productModel = StateObject(wrappedValue: ProductModel(apiService: apiService))
        _categoryModel = StateObject(wrappedValue: CagtegoryModel(apiService: apiService))
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(productModel)
                .environmentObject(categoryModel)
        }
    }
}
