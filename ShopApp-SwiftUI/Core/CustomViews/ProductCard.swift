//
//  ProductCard.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI
import Kingfisher

struct ProductCard: View {
    var product: Product

    var body: some View {
        VStack {

            KFImage(URL(string: product.thumbnail)!).resizable().aspectRatio(contentMode: .fit)
            Spacer()

            Text(product.title)
                .font(.headline)
                .padding()

            Spacer()

            Text(String(format: "$%.2f", product.price))
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}


