//
//  ProductDetailsScreen.swift
//  G Store MV
//
//  Created by Rezaul Islam on 14/1/24.
//

import SwiftUI

struct ProductDetailsScreen: View {
    @Environment(\.presentationMode) var pMode
    @EnvironmentObject private var model : ProductModel
    var body: some View {
        VStack(spacing: 16 ){
            toolBar
            imageView
            
            Spacer()
        }
        .hideNavigationBar
    }
}

extension ProductDetailsScreen{
    var toolBar : some View {
        HStack{
            Image(systemName: "arrow.backward")
                .onTapGesture {
                    pMode.wrappedValue.dismiss()
                }
            Spacer()
            Image(systemName: "heart")
        }
        .padding(.horizontal)
    }
    var imageView : some View{
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.gray.opacity(0.1))
            .frame(height: 300)
            .overlay(alignment: .center) {
                AsyncImage(url: URL(string: model.product.image ?? "")) { image in
                    image
                        .resizable()
                        //.frame(width: 100)
                        .aspectRatio( contentMode: .fit)
                        .cornerRadius(16)
                        .padding(.all)
                } placeholder: {
                    ProgressView()
                }

            }
            
    }
}

struct ProductDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsScreen()
            .environmentObject(ProductModel(apiService: APIService()))
        
    }
}
