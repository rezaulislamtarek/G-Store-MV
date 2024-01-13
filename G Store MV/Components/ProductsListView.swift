//
//  ProductsListView.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

struct ProductsListView: View {
    @EnvironmentObject private var model : ProductModel
    @State var shouldFetchAllProducts : Bool = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                ForEach(model.products) { product in
                    ProductRowView(product: product)
                }
            }
        }
        .onAppear{
            Task{
                if shouldFetchAllProducts {
                    try await model.getAllProducts()
                    shouldFetchAllProducts.toggle()
                }
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView()
            .environmentObject(ProductModel(apiService: APIService()))
    }
}

struct ProductRowView: View {
    let product: Product
    var body: some View {
        HStack() {
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 150 ,height: 150)
                .foregroundColor(.white.opacity(0.5))
                .overlay() {
                    AsyncImage(url: URL(string: product.image ?? "")) { image in
                        image.resizable()
                            .frame(width: 100, height: 120)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(16)
                            
                    } placeholder: {
                        ProgressView()
                    }
                }
                .shadow(color: .blue.opacity(0.2), radius: 0.5, x: 0.5, y: 0.5)
             
                
            VStack(alignment: .leading){
                Text(product.title ?? "")
                .font(.title3)
                .lineLimit(1)
                
                Text("$" + (product.price?.formatted() ?? "") )
            }
            
            
        }
    }
}
