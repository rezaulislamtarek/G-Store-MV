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
    @Published var product : Product = Product(title: "Product Name", image: imgUrl)
    let apiService : APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getAllProducts() async throws{
        products = try await apiService.getJSON(endPoint: Endpoints.allProducts)
    }
    
    func addNewProduct(_ product: Product) async throws{
        var _ : Product = try await apiService.postJSON(endPoint: Endpoints.allProducts, requestBody: product)
        products.append(product)
    }
    func updateProduct(_ product: Product) async throws{
        var _ : Product = try await apiService.putJSON(endPoint: Endpoints.updateProduct(product.id!), requestBody: product)
    }
}
