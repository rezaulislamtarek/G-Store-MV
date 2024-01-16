//
//  HorizontalCategories.swift
//  G Store MV
//
//  Created by Rezaul Islam on 16/1/24.
//

import SwiftUI

struct HorizontalCategories: View {
    @EnvironmentObject var categoriesModel : CagtegoryModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators:false) {
            HStack(spacing: 16 ){
                ForEach(categoriesModel.categories){ cat in
                    VStack(spacing: 2 ) {
                        Text(cat.name!.localizedCapitalized)
                            .font(.system(size: 14, design: .rounded))
                        if cat.isActive == true {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(height: 2)
                                .foregroundColor(.orange)
                        }
                    }
                        
                }
            }
        }
        .onAppear{
            Task{
                try? await categoriesModel.fetchAllCategory()
            }
        }
    }
}

struct HorizontalCategories_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCategories()
            .environmentObject(CagtegoryModel(apiService: APIService()))
    }
}
