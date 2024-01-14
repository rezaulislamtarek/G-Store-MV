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
    @Binding var tapped : Bool
    var body: some View {
        ScrollView(showsIndicators: false ) {
            VStack(alignment: .leading, spacing: 16){
                ForEach(model.products) { product in
                    ProductRowView(product: product)
                        .onTapGesture {
                            model.product = product
                            tapped.toggle()
                        }
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
        ProductsListView( tapped: .constant(false))
            .environmentObject(ProductModel(apiService: APIService()))
    }
}

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            
          
            NetworkImageView(imageUrl: product.image, width: 70, height: 70)
            
            Spacer()
                
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Spacer()
                    Image(systemName: "heart")
                        .foregroundColor(.gray.opacity(0.5))
                }
                
                Text( product.title?.truncateTitle ?? "")
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(1)
                
                Text("$ " + (product.price?.formatted() ?? "") )
                    .foregroundColor(.black)
                    .bold()
            }
           
            
            
        }
        .padding(.all, 16)
        .background(.gray.opacity(0.1))
        .cornerRadius(16)
        
    }
}
