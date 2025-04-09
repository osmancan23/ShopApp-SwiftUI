//
//  ContentView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Query(sort: \ProductData.id) private var products: [ProductData]

    var body: some View {
        TabView {

            HomeView().tabItem {
                VStack {
                    Image(systemName: "house")

                    Text("Home")
                }
            }

            BasketView().tabItem {
                VStack {
                    Image(systemName: "basket")

                    Text("Basket")
                }
            }
                .badge(products.count)


        }

    }
}

#Preview {
    ContentView()
}
