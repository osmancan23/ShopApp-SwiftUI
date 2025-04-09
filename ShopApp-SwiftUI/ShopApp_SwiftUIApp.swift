//
//  ShopApp_SwiftUIApp.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI
import SwiftData

@main
struct ShopApp_SwiftUIApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
          
            container = try ModelContainer(for: ProductData.self)
            print("SwiftData container başarıyla oluşturuldu")
        } catch {
            fatalError("SwiftData container oluşturulamadı: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
