//
//  BasketView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 7.04.2025.
//

import SwiftUI
import SwiftData
struct BasketView: View {
    
    @Query var products: [ProductData]

    var body: some View {
        NavigationStack {
            List {
                ForEach(products) { product in
                    Text("\(product.id)")
                }
            }
            .navigationTitle("FaceFacts")
            
        }
    }
}

#Preview {
    BasketView()
}
