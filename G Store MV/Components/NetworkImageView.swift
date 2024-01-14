//
//  ProductImageView.swift
//  G Store MV
//
//  Created by Rezaul Islam on 14/1/24.
//

import SwiftUI

struct NetworkImageView: View {
    var imageUrl : String?
    var width: Double
    var height: Double
    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { image in
            image.resizable()
                .frame(width: width, height: height)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
                
        } placeholder: {
            ProgressView()
        }
    }
    
}

struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImageView(imageUrl: "", width: 100, height: 100)
    }
}
