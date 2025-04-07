//
//  ContentView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI

struct ContentView: View {
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


        }

    }
}

#Preview {
    ContentView()
}
