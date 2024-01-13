//
//  Product.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import Foundation

struct Product : Codable, Identifiable{
    let id : Int?
    let title : String?
    let price : Double?
    let description : String?
    let category : String?
    let image: String?
}
