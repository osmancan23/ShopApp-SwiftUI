//
//  ResponseModel.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation

struct ResponseModel: Codable {
    let products: [Product]
    let total, skip, limit: Int
}
