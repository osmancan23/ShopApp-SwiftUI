//
//  Product.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation


// MARK: - Product
struct Product: Codable , Identifiable{
    let id: Int
    let title, description: String
    let price: Double
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
