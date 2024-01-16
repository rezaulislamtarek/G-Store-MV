//
//  CategoriesModel.swift
//  G Store MV
//
//  Created by Rezaul Islam on 16/1/24.
//

import Foundation

@MainActor
class CagtegoryModel : ObservableObject{
    var apiService : APIService
    @Published var categories : [Category] = []
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchAllCategory() async throws {
        let cats : [String] = try await apiService.getJSON(endPoint: Endpoints.categories)
        mapToCategory(cats: cats)
    }
    
    func mapToCategory(cats : [String]){
        var tempCategories : [Category] = []
        var i = 0
        cats.forEach { cat in
            tempCategories.append(Category(name: cat, isActive:i == 0 ? true : false))
            i += 1
        }
        categories = tempCategories
    }
    
}
