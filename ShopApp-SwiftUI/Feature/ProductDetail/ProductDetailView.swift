//
//  ProductDetailView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI
import Kingfisher


struct ProductDetailView: View {
    let product: Product
    @Environment(\.modelContext) private var modelContext
    @State var hasAddedToCart: Bool = false
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

                        HStack(content: {
                            Text(String(format: "$%.2f", product.price)).font(.title)
                            // Spacer()
                            Spacer()
                            Button("Add To Basket") {
                                modelContext.insert(ProductData(id: product.id))
                                hasAddedToCart = true
                            }
                                .buttonStyle(.bordered)
                                .background()
                                .alert(isPresented: $hasAddedToCart) {
                                Alert(
                                    title: Text("Success"),
                                    message: Text("The item has been added to your cart")
                                )
                            }
                        })
                      

                    }).padding(.leading, 0)

            })  .padding(.horizontal, 20)
    }
}

#Preview {
    ProductDetailView(product: .init(id: 1, title: "Test", description: "Test dasdas d asdas dasdasdasd asdasdasdasdaadsadsasd", price: 10, discountPercentage: 0, rating: 0, stock: 10, brand: "Test", category: "Test", thumbnail: "Test", images: ["Test"]))
}
