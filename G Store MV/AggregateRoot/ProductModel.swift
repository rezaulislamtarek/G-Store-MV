//
//  ProductModel.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import Foundation

@MainActor
class ProductModel : ObservableObject{
    
    @Published var products: [Product] = []
    let apiService : APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getAllProducts() async throws{
        products = try await apiService.getJSON(endPoint: "products")
        //print(products)
    }
    
    func addNewProduct(_ product: Product) async throws{
        var _ : Product = try await apiService.postJSON(endPoint: "products", requestBody: product)
        products.append(product)
    }
    func updateProduct(_ product: Product) async throws{
        var _ : Product = try await apiService.putJSON(endPoint: "products/\(product.id)", requestBody: product)
    }
}
