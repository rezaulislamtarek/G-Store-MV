//
//  Category.swift
//  G Store MV
//
//  Created by Rezaul Islam on 16/1/24.
//

import Foundation

struct Category : Identifiable{
    var id = UUID()
    let name : String?
    var isActive : Bool?
}
