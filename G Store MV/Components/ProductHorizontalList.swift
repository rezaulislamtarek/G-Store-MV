//
//  ProductHorizontalList.swift
//  G Store MV
//
//  Created by Rezaul Islam on 14/1/24.
//

import SwiftUI

struct ProductHorizontalList: View {
    @EnvironmentObject var model: ProductModel
    @Binding var tapped : Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(model.products){ product in
                    ProductHorizontalListItem(product: product)
                        .onTapGesture {
                            model.product = product
                            tapped.toggle()
                        }
                }
            }
            .onAppear{
                Task{
                    if model.products.count == 0 {
                        try? await model.getAllProducts()
                    }
                }
        }
        }
    }
}

struct ProductHorizontalList_Previews: PreviewProvider {
    static var previews: some View {
        ProductHorizontalList(tapped: .constant(false))
            .environmentObject(ProductModel(apiService: APIService()))
    }
}

 

struct ProductHorizontalListItem: View {
    var product : Product
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.gray.opacity(0.1))
            .frame(width: 220)
            .frame(minHeight: 220)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading,  spacing: 4){
                    Image(systemName: "heart")
                    NetworkImageView(imageUrl: product.image, width: 60, height: 70)
                    Text(product.title?.truncateTitle ?? "")
                        .lineLimit(1)
                    
                    Text("Trending Now")
                        .foregroundColor(.orange)
                        .fontWeight(.light)
                    Text("$ " + (product.price?.formatted() ?? ""))
                        .bold()
                }
                .padding(.all, 24)
            }
    }
}
