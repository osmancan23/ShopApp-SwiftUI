//
//  HomeViewModel.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel : ObservableObject {
        
    let productService : ProductServiceProtocol = ProductService(networkManager: NetworkManager())
    
  
    // İki sütunlu grid yapısı
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]

    
    func fetchProducts(onSuccess: @escaping (ResponseModel) -> Void, onFailed: @escaping (String) -> Void)  {
        productService.fetchProducts(onSuccess: onSuccess, onFailed: onFailed)

    }
}
