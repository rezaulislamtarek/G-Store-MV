//
//  Config.swift
//  G Store MV
//
//  Created by Rezaul Islam on 14/1/24.
//

import Foundation

enum Endpoints{
    case allProducts
    case updateProduct(Int)
    case categories
    
    var path: String{
        switch self{
        case .allProducts:
            return "products/"
        case .updateProduct(let id):
            return "products/\(id)"
        case .categories:
            return "/products/categories"
        }


    }
}

struct Configuration{
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        if env == "TEST" {
            return AppEnvironment.test
        }
        return AppEnvironment.dev
    }()
}

enum AppEnvironment : String{
    case dev
    case test
    
    var baseUrl : URL {
        switch self {
        case .dev:
            return URL(string: "https://fakestoreapi.com")!
        case .test:
            return URL(string: "https://fakestoreapi.com")!
        }
    }
}
