//
//  Product.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import Foundation

struct Product : Codable, Identifiable{
    var id : Int? = 0
    var title : String? = ""
    var price : Double? = 0.0
    var description : String? = ""
    var category : String? = ""
    var image: String? = ""
}
