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
            HStack(spacing: 24 ){
                ForEach(categoriesModel.categories){ cat in
                    VStack(spacing: 4 ) {
                        Text(cat.name!.localizedCapitalized)
                            .font(.system(size: 14, design: .rounded))
                        
                        if cat.isActive == true {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(height: 2)
                                .foregroundColor(.orange)
                        }
                    }
                    .onTapGesture {
                        let deSelected = categoriesModel.categories.firstIndex{ $0.isActive == true }
                        let selected =  categoriesModel.categories.firstIndex { $0.id == cat.id }
                        categoriesModel.categories[deSelected!].isActive?.toggle()
                        categoriesModel.categories[selected!].isActive?.toggle()
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
    
    func makeFunc(a: Int) -> Bool{
        return true
    }
}

struct HorizontalCategories_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCategories()
            .environmentObject(CagtegoryModel(apiService: APIService()))
    }
}
