//
//  HomeViewModel.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let productService: ProductServiceProtocol = ProductService(networkManager: NetworkManager())
    
    // İki sütunlu grid yapısı
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    func fetchProducts() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await productService.fetchProducts()
                products = response.products
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
