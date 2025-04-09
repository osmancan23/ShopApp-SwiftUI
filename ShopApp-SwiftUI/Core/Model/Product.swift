//
//  Product.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation
import SwiftData

// MARK: - Product
struct Product: Codable , Identifiable {
    let id: Int
    let title, description: String
    let price: Double
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String?
    let thumbnail: String
    let images: [String]
}

@Model
final class ProductData: Identifiable {
    @Attribute(.unique) var id: Int
    var title: String
    var productDescription: String
    var price: Double
    var thumbnail: String
    var imagesList: [String]
    
    init(id: Int, title: String, description: String, price: Double, thumbnail: String, images: [String]) {
        self.id = id
        self.title = title
        self.productDescription = description
        self.price = price
        self.thumbnail = thumbnail
        self.imagesList = images
    }
}
