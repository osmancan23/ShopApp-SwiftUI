//
//  Route.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation

enum Route {
    
    static let baseUrl  = "https://dummyjson.com/"
    
    case products
    case product(id : Int)
    
    var value : String {
        
        switch self {
            case .products : return "products?limit=30"
            
            case .product( let id) : return "products/\(id)"
            
        }
    }
    
}
