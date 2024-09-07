//
//  ProductDetailView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI
import Kingfisher


struct ProductDetailView: View {
    let product : Product
    
    var body: some View {
        VStack(
            alignment: .leading,
            
            content: {
                
                Spacer().frame(height: 20)
                KFImage(product.images.first?.asUrl).resizable().aspectRatio(contentMode: .fit).frame(width: 300, height: 300)
                Spacer().frame(height: 50)
                VStack(
                    alignment: .leading,
                    content: {
                        Text(product.title).font(.largeTitle).fontWeight(.bold)
                        Spacer().frame(height: 20)
                        Text(product.description)
                        Spacer().frame(height: 20)

                        ZStack(alignment:.trailing, content: {
                            Text("\(product.price)$").font(.title)
                        })
                    
                }).padding(.leading,0)
               
            })
    }
}

