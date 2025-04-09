//
//  BasketView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 7.04.2025.
//

import SwiftUI
import SwiftData
import Kingfisher

struct BasketView: View {
    @Query(sort: \ProductData.id) private var products: [ProductData]
    @Environment(\.modelContext) private var modelContext
    @State var totalPrice : Double = 0
    var body: some View {
        NavigationStack {
            List {
                if products.isEmpty {
                    Text("Sepetiniz boş")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(products) { product in
                        HStack {
                            KFImage(URL(string: product.thumbnail))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.headline)
                                Text(String(format: "$%.2f", product.price))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                        }
                        .swipeActions {
                            Button(action: {
                                modelContext.delete(product)
                                try? modelContext.save()
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }

                        }
                    }
                }
                
                Text("Total: \(String(format: "$%.2f", totalPrice))")
                    
            }
            .navigationTitle("Basket")
            .onAppear() {
                totalPrice = 0
                for product in products {
                    self.totalPrice += product.price
                }
            }
            
        }
    }
}

#Preview {
    BasketView()
        .modelContainer(for: ProductData.self, inMemory: true)
}
