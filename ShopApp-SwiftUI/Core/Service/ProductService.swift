//
//  ProductService.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation

protocol ProductServiceProtocol {
    var networkManager: NetworkManager { get }
    
    func fetchProducts() async throws -> ResponseModel
    func fetchProductWithId(_ id: Int) async throws -> Product
}

struct ProductService: ProductServiceProtocol {
    var networkManager: NetworkManager
    
    func fetchProducts() async throws -> ResponseModel {
        return try await networkManager.request(route: .products, method: .get)
    }
    
    func fetchProductWithId(_ id: Int) async throws -> Product {
        return try await networkManager.request(route: .product(id: id), method: .get)
    }
}

