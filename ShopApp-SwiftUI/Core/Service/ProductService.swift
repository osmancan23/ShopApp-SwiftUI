//
//  ProductService.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation

protocol ProductServiceProtocol {
    
    var networkManager : NetworkManager { get }
    
    
    func fetchProducts(onSuccess: @escaping (ResponseModel) -> Void , onFailed: @escaping (String) -> Void)

}


struct ProductService : ProductServiceProtocol {
    var networkManager: NetworkManager
    
    func fetchProducts(onSuccess: @escaping (ResponseModel) -> Void, onFailed: @escaping (String) -> Void) {
        networkManager.request(onSuccess: onSuccess, onFailed: onFailed, route: .products, method: .get)
    }
    
    
}

