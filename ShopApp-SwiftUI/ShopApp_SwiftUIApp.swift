//
//  ShopApp_SwiftUIApp.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 6.09.2024.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseAuth
class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct ShopApp_SwiftUIApp: App {
    
    let container: ModelContainer
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

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
            InitialView()
        }
        .modelContainer(container)
    }
}
